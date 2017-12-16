//
//  MessageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 12/3/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//


import UIKit
import JSQMessagesViewController

class MessageViewController: JSQMessagesViewController {
    
    // local property to store messages in array form
    var messages = [JSQMessage]()
    
    // both incoming/outgoing are computed properties
    // they are laxy meaning they are only intiialized once when they're accessed
    lazy var outgoingBubble: JSQMessagesBubbleImage = { // BUBBLE FUNCTION 1
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = { // BUBBLE FUNCTION 2
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // create a temp constant
        let defaults = UserDefaults.standard
        self.navigationItem.title = "IM Chat"
        
        // check if the keys exist in the user default
        // if they do exist assign their values
        if  let id = defaults.string(forKey: "jsq_id"),
            let name = defaults.string(forKey: "jsq_name")
        {
            senderId = id
            senderDisplayName = name
        }
            // otherwise...
            // assign a random numeric string to senderId and an empty string to senderDisplayName
        else
        {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = ""
            // Save the new senderId in the user defaults, for key jsq_id
            // and save the user defaults (with synchronize())
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            //showDisplayNameDialog()
        }
        // change the view controller title
        title = "Chat: \(senderDisplayName!)"
        
        /*
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
         tapGesture.numberOfTapsRequired = 1
         
         navigationController?.navigationBar.addGestureRecognizer(tapGesture)
         */
        // hides the attachment button on the left of the chat text input field
         inputToolbar.contentView.leftBarButtonItem = nil
 
        
        // set the avatar size to zero, again, hiding it
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        
        // creates a query to get the last 10 messages
        // preparation for retrieval
        let query = Constants.refs.databaseChats.queryLimited(toLast: 100)
        
        // observe the query for newly added chat data , then call a closure
        // when there's new data
        // actual retrieval
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            // Data is unpacked:
            // The if let statement uses optional binding to unwrap and
            // cast snapshot to a dictionary of strings. Subsequent lines
            // then assign values of that dictionary to constants.
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                // new JSQMessage object created
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    // put the JSQMessage in the end of the messages array
                    self?.messages.append(message)
                    // prompts JSQMVC to refresh the UI and show the new message
                    self?.finishReceivingMessage()
                }
            }
        })
        
    }
    
    // returns an item from messages based on the index from indexPath.item
    // effectively returning the message data for a particular message by its index
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    // Returns the total number of messages, based on messages.count – the amount
    // of items in the array!
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // another delegate, that’s called by JSQMVC when it needs bubble image data.
    // Inside the function the ternary conditional operator a ? b : c is used to
    // return the right bubble
    // a: When messages[indexPath.item].senderId == senderId is true, return outgoingBubble
    // b: When that expression is false, return incomingBubble
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    // Returns nil when JSQMVC wants avatar image data, effectively hiding the avatars.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    // label shows up on top of the message bubble, and you can use it to display the name
    // of the user that sent the chat message
    // note: messages[indexPath.item].senderDisplayName -> acceses particular message by index
    // then uses the property sendDisplayName on the resulting object
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    // When the user has typed a chat message, and then presses the Send button, in the app
    // we will send it to Firebase
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        // craete a reference to a new value in Firebase on the /chats node using childByAutoId()
        let ref = Constants.refs.databaseChats.childByAutoId()
        
        // create a dictionary that contains all info about the ro-be-sent message
        // senderId, dispaly name, chat text
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        // set ref to value - store dictionary in newly created node
        // data for message is provided via function paramters, so JSQ tells you
        // what the user typed in the chat field
        ref.setValue(message)
        
        // tells JSQMVC we're done and updates the UI
        finishSendingMessage()
        
        
    }
}

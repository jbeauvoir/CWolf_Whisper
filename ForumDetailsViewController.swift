//
//  ForumDetailsViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class ForumDetailsViewController: UIViewController {

    @IBAction func CommentButtonClick(_ sender: Any) {
       // performSegue(withIdentifier: "ShowCommentDetails", sender: self)
    }
    @IBOutlet weak var LikeButton: UIImageView!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var NumOfLikesLabel: UILabel!
    @IBOutlet weak var forumBodyLabel: UILabel!
    @IBOutlet weak var ForumPicture: UIImageView!
    @IBOutlet weak var ForumTitle: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var likedView: UIImageView!
    @IBOutlet weak var NumOfCommentsLabel: UILabel!
    
    
    let settingLauncher = SettingLauncher()
    var numberOfLikesForForum = 0
    var forum: Forum?
    var forumArray = [Forum]()
    let del = UIApplication.shared.delegate as? AppDelegate
    var AlreadyLiked: Bool = false

    
    @IBAction func likeButtonClicked(_ sender: Any) {
        likedView.isHidden = false //set a boolean so that that user cant see again next time they return
        //Add functionality if the button is pressed change the color and save the state for that user/ let them not click again
        //add update how manny likes the forum has
        if AlreadyLiked == false {
        updateLikesForForum()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlreadyLiked = false
        likedView.isHidden = true
        self.navigationItem.title = "Forums"
    }
    
    func showChatControllerForUser(_ forumToset: Forum, forum_id: String){
        del?.forum = forumToset
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
 
        forum = del?.forum
        forumArray = [forum!]
        ////Title and profile name
        let ForumTitleTemp: String = forumArray[0].forumName1!
        ForumTitle.text = (forum?.userNameForForum()!)! + " - " + ForumTitleTemp
        ForumTitle.adjustsFontSizeToFitWidth = true
        ForumTitle.sizeToFit()
       
        ////user picture
        if let profileImage = forumArray[0].userProfileImage() {
            userimage.backgroundColor = UIColor.green //grab user profile from DB change to optional
            userimage.layer.cornerRadius = 22
            userimage.clipsToBounds = true
            userimage?.image = profileImage
        }
        else {
            userimage?.image = #imageLiteral(resourceName: "loadicon")
        }
        /////Body
        forumBodyLabel.text = forumArray[0].forumBody1 //maybe make it better
        ForumPicture.translatesAutoresizingMaskIntoConstraints = false
        forumBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        if let aImage = forumArray[0].forumPictureImage()  {
            ForumPicture.image = aImage
            ForumPicture.contentMode = UIViewContentMode.scaleAspectFit
        }
        else {
           // self.ForumPicture.removeFromSuperview()
           
            let CGrectForBodyLabel = CGRect(origin: CGPoint(x: 20,y :150), size: CGSize(width: 300, height: 300))
                forumBodyLabel.frame = CGrectForBodyLabel
            }
            //make it so it expand over manny lines
            forumBodyLabel.lineBreakMode = .byWordWrapping
            forumBodyLabel.numberOfLines = 0
            forumBodyLabel.sizeToFit()
        
        if let numberOfLikes = forum?.forumLikes() {
            NumOfLikesLabel.text = numberOfLikes
        }
        
        if let numberOfComments = forum?.forumComments() {
            NumOfCommentsLabel.text = numberOfComments
        }
    }
    
    func updateLikesForForum(){
        var Forum_IDToCheck = forumArray[0].forum_id1
        let tempString: String = NumOfLikesLabel.text!
        var tempInt: Int = Int(tempString)!
        tempInt += 1
        var stringToSendBack: String = String(tempInt)
        NumOfLikesLabel.text = stringToSendBack
        Constants.refs.databaseForums.child(Forum_IDToCheck!).child("forum_likes").setValue(stringToSendBack)
        AlreadyLiked = true
    }
    
    
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "CommentTableViewController" {
            print("OVERRIDING THE SEGUE")
            performSegue(withIdentifier: "CommentTableViewController", sender: nil)
        }
        
    }
    
}







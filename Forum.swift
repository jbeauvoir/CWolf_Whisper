//
//  Forum.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit


class Forum: NSObject {
    var home: Bool = false
    let forum: AnyObject
    let del = UIApplication.shared.delegate as? AppDelegate
    
    init(forum: AnyObject)
    {
        self.forum = forum
        super.init()
    }
    
    func forumName() -> String?
    {
        if let f = forum["forum_name"] {
            return f as? String
        }
        return nil
    }
   
    func forumBody() -> String?
    {
        if let f = forum["forum_body"] {
            return f as? String
        }
        return nil
    }
    
    func forumSubTitle() -> String?
    {
        if let f = forum["forum_subtitle"]{
            return f as? String
        }
        return nil
    }
    
    func forumType()-> String?{
        if let f = forum["forum_type"]{
            return f as? String
        }
        return nil
    }
    
    func setNumberOfCellsNotUsed(){
        del?.numOfUnusedCells += 1
    }
    
    func returnNumberOfCellsNotUsed()->Int{
        return del!.numOfUnusedCells
    }
    
    func userProfileImage() -> UIImage?
    {
        if let uriString = forum["userProfileImage"], let uri = uriString as? String {
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
   func numberOfLikes() -> Int?
   {
    if let f = forum["forum_likes"]{
        return f as? Int
        }
        return nil
    }
    
    func numberOfComments() -> Int?
    {
        if let f = forum["forum_comments"]{
            return f as? Int
        }
        return nil
    }

    func userNameForForum() -> String?
    {
        if let f = forum["forum_creator"]{
            return f as? String
        }
        return nil
    }
    
    func getImage() ->UIImage?
    {
        if let uriString = forum["uri"], let uri = uriString as? String {
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func setUseCellOrNot(){
        del?.useCellOrNot = true
    }
    
    //Forum Table getters and Setters
    func setuserProfileImage() -> UIImageView? {
       let imageView = UIImageView()
        imageView.backgroundColor = UIColor.green //grab user profile from DB change to optional
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    
    //use the profile picture from database
    //Not gonna use
  
    func setthumbnailImageView() -> UIImageView?
    {
        let imageView = UIImageView()
        // grab from DB change to optional
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

 
    func setseperateTabelView() -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1) 
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setforumTitleLabel() -> UILabel {
        let forumLabel = UILabel()
        //forumLabel.backgroundColor = UIColor.purple // grab from DB change to optional
        forumLabel.translatesAutoresizingMaskIntoConstraints = false
        return forumLabel
    }
 
    func setforumSubTitle() -> UITextView{
        let textview = UITextView()
        //textview.backgroundColor = UIColor.red //// grab from DB change to optional
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textview.textColor = UIColor.lightGray
        textview.isUserInteractionEnabled = false
        return textview
    }
    
}

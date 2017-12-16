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
    var forumCreatorName1: String?
    var forumName1: String?
    var forumBody1: String?
    var forumsubtitle1: String?
    var forumType1: String?
    var profileImageUrl: String?
    var forum_id1: String?
    var forum_likes1: String?
    var num_comments1: String?
    var forum_picture1: String?
    
    init(forum: [String: Any])
    {
        self.forum = forum as AnyObject
        super.init()
        
        self.forumName1 = forum["forum_name"] as? String
        self.forumBody1 = forum["forum_body"] as? String
        self.forumsubtitle1 = forum["forum_subtitle"] as? String
        self.forumType1 = forum["forum_type"] as? String
        self.profileImageUrl = forum["user_image"] as? String
        self.forumCreatorName1 = forum["forum_creator"] as? String
        self.forum_id1 = forum["forum_id"] as? String
        self.forum_likes1 = forum["forum_likes"] as? String
        self.num_comments1 = forum["num_comments"] as? String
        self.forum_picture1 = forum["forum_picture"] as? String
    }

    func forumID() -> String?
    {
        if let f = forum["forum_likes"] {
            return forum_likes1
        }
        return nil
    }
    
    func forumComments() -> String?
    {
        if let f = forum["num_comments"] {
            return num_comments1
        }
        return nil
    }
    
    
    func forumLikes() -> String?
    {
        if let f = forum["forum_id"] {
            return forum_id1
        }
        return nil
    }
    
    func forumCreatorName() -> String?
    {
        if let f = forum["forum_name"] {
            return forumCreatorName1
        }
        return nil
    }
    
    func forumName() -> String?
    {
        if let f = forum["forum_name"] {
            return forumName1
        }
        return nil
    }
    
    func forumBody() -> String?
    {
        if let f = forum["forum_body"] {
            return forumBody1
        }
        return nil
    }
    
    func forumSubTitle() -> String?
    {
        if let f = forum["forum_subtitle"]{
            return forumsubtitle1
        }
        return nil
    }
    
    func forumType()-> String?{
        if let f = forum["forum_type"]{
            return forumType1
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
        if let uriString = forum["user_image"], let uri = uriString as? String {
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func forumPictureImage() -> UIImage?
    {
        if let uriString = forum["forum_picture"], let uri = uriString as? String {
            print(uriString)
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    
    func getImage() ->UIImage? //image for forum
    {
        if let uriString = forum["uri"], let uri = uriString as? String {
            print(uriString)
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

    func getForumID() -> AnyObject? //image for forum
    {
        if let string = forum["forum_id"], let result = string as? AnyObject{
            return result
        }
        return nil
    }
    
    func setUseCellOrNot(){
        del?.useCellOrNot = true
    }
    
    //Forum Table getters and Setters
    func setuserProfileImage() -> UIImageView? {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.rgb(red: 131, green: 177, blue: 255) //grab user profile from DB change to optional
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }
    
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
        return view
    }
    
    func setforumTitleLabel() -> UILabel? {
        let forumLabel = UILabel()
        forumLabel.translatesAutoresizingMaskIntoConstraints = false
        forumLabel.numberOfLines = 2
        //forumLabel.backgroundColor = UIColor.purple // grab from DB change to optional
       
        return forumLabel
    }
    
    func setForumPicture() -> UIImageView {
        let imageView = UIImageView()
        // grab from DB change to optional
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func setforumSubTitle() -> UILabel?{
        let textview = UILabel()
        //textview.backgroundColor = UIColor.red //// grab from DB change to optional
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.textColor = UIColor.lightGray
        textview.isUserInteractionEnabled = false
        return textview
    }
    
}

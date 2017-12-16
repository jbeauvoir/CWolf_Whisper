//
//  Comment.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class Comment: NSObject {

    let comment: AnyObject
    let del = UIApplication.shared.delegate as? AppDelegate
    var commentbody: String?
    var commentCreator: String?
    var userImage: String?
    var getImage1: String?
    
    
    init(comment: [String: Any]) {
        self.comment = comment as AnyObject
        super.init()
        
        self.commentbody = comment["comment_body"] as? String
        self.commentCreator = comment["comment_creator"] as? String
        self.userImage = comment["user_image"] as? String
        self.getImage1 = comment["uri"] as? String
        
    }
    
    func commentCreatorName() -> String? {
        if let c = comment["comment_creator"] {
            return commentCreator
        }
        return nil
    }
    
    func commentBody() -> String? {
        if let c = comment["comment_body"] {
            return commentbody
        }
        return nil
    }
    /*
     func forumCreator() -> String? {
     if let f = forum["forum_creator"] {
     return f as? String
     }
     return nil
     }
     */
    func getImage() ->UIImage? {
        if let uriString = comment["uri"], let uri = uriString as? String {
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    
    func userProfileImage() -> UIImage?
    {
        if let uriString = comment["user_image"], let uri = uriString as? String {
            if let url = URL(string: uri),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }
    


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

func setforumCommentLabel() -> UILabel? {
    let forumLabel = UILabel()
    //forumLabel.backgroundColor = UIColor.purple // grab from DB change to optional
    forumLabel.translatesAutoresizingMaskIntoConstraints = false
    return forumLabel
}
}





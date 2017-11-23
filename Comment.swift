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
    
    init(comment: AnyObject) {
        self.comment = comment
        super.init()
    }
    
    func commentCreatorName() -> String? {
        if let c = comment["comment_creator"] {
            return c as? String
        }
        return nil
    }
    
    func commentBody() -> String? {
        if let c = comment["comment_body"] {
            return c as? String
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
    
    
}

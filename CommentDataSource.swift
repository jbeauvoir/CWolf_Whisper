//
//  CommentDataSource.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit


class CommentDataSource: NSObject {
    
    var comments: [AnyObject]
    
    init(dataSource: [AnyObject]){
        comments = dataSource
        super.init()
    }
    
    func numComments() -> Int{
        return comments.count
    }
    
    func commentAt(_ index: Int) -> Comment{
        let comment = Comment(comment: comments[index] as! [String : Any])
        return comment
    }
    
}


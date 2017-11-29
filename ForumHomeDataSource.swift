//
//  ForumHomeDataSource.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/28/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class ForumHomeDataSource: NSObject {
    var forums: [AnyObject]
    
    init(dataSource: [AnyObject]){
        forums = dataSource
        super.init()
    }
    
    func numForums() -> Int{
        return forums.count
    }
    
    func forumAt(_ index: Int) -> Forum{
        let forum = Forum(forum: forums[index])
        return forum
    }
    

}

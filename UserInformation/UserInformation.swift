//
//  UserInformation.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/14/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import StitchCore // cloud services
import ExtendedJson
import MongoDBService // Database

class UserInformation: NSObject {
    
    //var userID: String
    var email: String = String()
    var password: String = String()
    var forums: [String] = [String]()
    
    init(email: String, password: String, forums: [String]){
        //super.init()
        //self.email = ""
        //self.password = ""
        //self.forums = [""]
        print("got here", email, password, forums)
        
    }
    //{
        //self.userID = ""
        //self.email = ""
        //self.password = ""
        //self.forums = [""]
        //super.init()
    //}

}

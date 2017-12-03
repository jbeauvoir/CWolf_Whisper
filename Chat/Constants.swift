//
//  Constants.swift
//  UserLoginAndRegistration
//
//  Created by Jacques Beauvoir on 12/2/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        // You’re creating two static constants called databaseRoot and databaseChats.
        // The root uses a function to get a reference to the root of the database, and
        // then databaseChats “extends” that with a child node called chats.
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
    // The code above is a nested struct, a structure to store variables in. Whenever
    // you now need access to the reference for chat data, you can use: Constants.refs.databaseChats

}


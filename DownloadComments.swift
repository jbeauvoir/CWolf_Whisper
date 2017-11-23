//
//  DownloadComments.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class DownloadComments: NSObject {
    var urlString: String
    @objc dynamic var dataFromServer: [AnyObject]? // added the @obj
    
    init(withURLString: String) {
        urlString = withURLString
        super.init()
    }
    
    func download_request()
    {
        
        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url)
                
                if let data = contents.data(using: .utf8) {
                    dataFromServer = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
}

    


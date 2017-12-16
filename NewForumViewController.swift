//
//  NewForumViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 12/4/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class NewForumViewController: UIViewController {

    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addBodyTextField: UITextView!
    @IBOutlet weak var addType: UITextField!
    @IBOutlet weak var addPicture: UITextField!
    
    
     let del = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let addTitle = addTitleTextField.text
        let addBody  = addBodyTextField.text
        let addPic   = addPicture.text
        let addForumtype  = addType.text
        
        if(addTitle!.isEmpty || addBody!.isEmpty) {
            
        } else {
            let forum_id = String(arc4random_uniform(999999))
            //let ref   = Constants.refs.databaseForums.childByAutoId()
            let ref   = Constants.refs.databaseForums.child(forum_id)
            let forum = ["forum_body": addBody, "forum_comments": "", "forum_creator": "", "forum_id": forum_id, "forum_likes": "0", "forum_name": addTitle, "forum_subtitle": "Check it", "forum_type": addForumtype, "forum_picture": addPic ] as [String : Any]
            ref.setValue(forum)
        }
    }
}

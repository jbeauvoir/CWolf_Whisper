//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/1/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    var userUid: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false;

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginView", sender: self)
        
    }
    
    
    /*
    func goToCreateUserVC() {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
    
    func goToForumVC() {
        print("go to forum called")
        performSegue(withIdentifier: "ToForum", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp" {
            if let destination = segue.destination as? CreateUserViewController {
                if userUid != nil {
                    destination.userUid = userUid
                }
                if emailField.text != nil {
                    destination.emailField = emailField.text
                }
                if passwordField.text != nil {
                    destination.passwordField = passwordField.text
                }
            }
        }
    }
    */
}


//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/1/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterPageViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        // CHECK FOR EMPTY FIELDS
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill out all the fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        if usernameTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill out all the fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        if passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill out all the fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        if repeatTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill out all the fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
            
            // END CHECK FOR EMPTY FIELDS
            
        else {
            // CREATE A USER IN FIREBASE
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                // IF THERES NO SIGN UP ERRORS PROGRESS
                if error == nil {
                    print("You have successfully signed up")
                }
                
            }
        }
        //let ref = Constants.refs.databaseUsers.child()
        let ref = Constants.refs.databaseUsers.childByAutoId()
        let user = ["username": usernameTextField.text!, "email": emailTextField.text!, "picture": nil]
        ref.setValue(user)
    }
    
 

}

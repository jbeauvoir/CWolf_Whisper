//
//  LoginViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/10/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var yes : Bool = false
let del = UIApplication.shared.delegate as? AppDelegate

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerButton(_ sender: Any) {
       // if yes == false{
        //shouldPerformSegue(withIdentifier: "registerView", sender: Any?.self)
       // }
        //else{}
        
    }
    
   @IBAction func loginButton(_ sender: Any) {
    
        del?.userNameEmail = emailTextField.text!
        shouldPerformSegue(withIdentifier: "toForum", sender: Any?.self)
    }
    
   
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier { // START IF LET
            if ident == "registerView" {
                return true
            }
            if ident == "toForum" { // START FORUM IF
                if self.emailTextField.text! == "" || self.passwordTextField.text! == "" {
                    print("inside null email or password case")
                    //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                    let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return false
                } else {// end self if -----START ELSE 1
                    print("inside authorization")
                    print(emailTextField)
                    print(passwordTextField)
                    
                    Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in if

                        error == nil { // START CLOSURE 1
                        print("right before auth of user")
                        if let user = Auth.auth().currentUser { // START CLOSURE 2
                            if !user.isEmailVerified{ // START CLOSURE 3
                                print("inside email not verified")
                                let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(self.emailTextField.text).", preferredStyle: .alert) // END ALERTVC
                                let alertActionOkay = UIAlertAction(title: "Okay", style: .default) { // START ALERT ACTION OK CLOSURE
                                    (_) in user.sendEmailVerification(completion: nil) }
                                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                                // ALERT VC ACTIONS
                                alertVC.addAction(alertActionOkay)
                                alertVC.addAction(alertActionCancel)
                                self.present(alertVC, animated: true, completion: nil)
                            }
                            if user.isEmailVerified{
                                print ("Email verified. Signing in...")
                                
                            }
                        }
                        }
                    }
                    return true
                } // END FORUM IF
            }// END if let
            return false
        }
        return false
    }
}

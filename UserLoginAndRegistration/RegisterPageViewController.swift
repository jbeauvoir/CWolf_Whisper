//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/1/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        //check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty)
        {
        //display alert
            displayMyAlertsMessage(userMessage: "All fields are required")
        }
        if (userPassword != userRepeatPassword)
        {
            displayMyAlertsMessage(userMessage: "Passwords dont match")
        }
        
        //stpre data
        
        
        
    }
    
    func  displayMyAlertsMessage(userMessage:String)
    {
        //var myAlert = UIAlertController(title:"Alert", message: userMessage,preferredStyle: UIAlertControllerStyle.alert)
        
       // let okAction = UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler:nil)
        
       //myAlert.addAction(okAction)
        
       //self.presentedViewController(myAlert, )

    }
/*  https://www.youtube.com/watch?v=PKOswUE731c */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

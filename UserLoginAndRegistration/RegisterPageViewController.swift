//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/1/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import StitchCore
import ExtendedJson
import MongoDBService


let stitchClient = StitchClient(appId: "seawolfwhispher-tjmeq")
let mongoClient = MongoDBClient(stitchClient: stitchClient, serviceName: "mongodb-atlas")
let db = mongoClient.database(named: "ssuDataBase")


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
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        print("email: ", email.text!)
        print("password: ", password.text!)
        print("repeat: ", repeatPassword.text!)
        
        //check for empty fields
        if(email.text!.isEmpty || password.text!.isEmpty || repeatPassword.text!.isEmpty)
        {
        //display alert
            displayMyAlertsMessage(userMessage: "All fields are required")
        }
        if (password.text! != repeatPassword.text!)
        {
            displayMyAlertsMessage(userMessage: "Passwords dont match")
        }
        
        
        if(!email.text!.isEmpty && !password.text!.isEmpty && !repeatPassword.text!.isEmpty){
            if(password.text! == repeatPassword.text!){
                
                let createdUser: UserInformation = UserInformation(email: email.text!, password: password.text!,  forums: [])
                print("email: ", email.text!)
                
                stitchClient.anonymousAuth().then { (userId: String) -> StitchTask<Document> in
                    return db.collection(named: "ssuDatabase.Users")
                        .updateOne(query: ["owner_id": userId],
                                   update: ["userEmail": self.email.text!,
                                            "userPassword": self.password.text!,
                                            // "userFavoriteForums": [],
                                            "owner_id": userId],
                                   upsert: true)
                    // }.then { (doc: Document) -> StitchTask<[Document]> in
                    }.then { (doc: StitchTask<Document>) -> StitchTask<[Document]> in
                        return db.collection(named: "ssuDatabase.Users")
                            // .find(query: ["owner_id": stitchClient.userId!], limit: 100)
                            .find(query: ["userEmail": "aa"], limit: 100)
                    }.then { (docs: [Document]) in
                        print("docs", docs)
                    }.catch { err in
                        print(err)
                }
            }
        }
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

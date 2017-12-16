//
//  CatagoryViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/22/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class CatagoryViewController: UIViewController {
    
    let del = UIApplication.shared.delegate as? AppDelegate
  
   
    @IBOutlet weak var social: UIButton!
    @IBAction func socialImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "social"
         self.del?.catBool = true

    }
    @IBAction func socialLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "social"
        self.del?.catBool = true
    }
    ///////
    @IBAction func sportsImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "sports"
         self.del?.catBool = true
    }
    @IBAction func sportsLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "sports"
         self.del?.catBool = true
    }
    
    @IBAction func generalInfoLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "help"
         self.del?.catBool = true
    }
    @IBAction func generalInfoImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "help"
         self.del?.catBool = true
    }
    ////
    @IBAction func jokesLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "jokes"
         self.del?.catBool = true
    }
    @IBAction func jokesImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "jokes"
         self.del?.catBool = true
    }
    ////
    @IBAction func schoolLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "school"
         self.del?.catBool = true
    }
    @IBAction func schoolImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "school"
         self.del?.catBool = true
    }
    ////
    @IBAction func buySellLabelButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "buySell"
        self.del?.catBool = false
        self.del?.home = true
    }
    @IBAction func buySellImageButton(_ sender: Any) {
        self.del?.whichSettingButtonIClicked = "buySell"
        self.del?.catBool = false
        self.del?.home = true
    }
    ////
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func whichSettingButtonWasClicked(stringToCheck: String){
        
        
        if stringToCheck == "" {
            print("error, empty string, Continue")
        }
        else{
            
            if stringToCheck == "social" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            }
            
            if stringToCheck == "sports" {
                performSegue(withIdentifier: "NewForumViewContoler", sender: nil)
                
            }
            if stringToCheck == "help" {// complete
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
                
            }
            if stringToCheck == "jokes" { //complete
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
                
            }
            if stringToCheck == "school" { //complete
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
                
            }
            if stringToCheck == "buySell" { //complete
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
                
            }
        }
    }
}

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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginView", sender: self)
        
    }
}


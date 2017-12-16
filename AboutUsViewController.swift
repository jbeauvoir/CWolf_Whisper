//
//  AboutUsViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/28/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    @IBOutlet weak var AboutUsView: UIView!
    @IBOutlet weak var AboutUsTitleLabel: UILabel!
    @IBOutlet weak var AboutUsBodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationItem.title = "About Our Team"
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setup(){
        AboutUsBodyLabel.textAlignment = .left
        AboutUsBodyLabel.adjustsFontSizeToFitWidth = true
        AboutUsBodyLabel.text = "C-Wolf Whisper consists of 3 great guys. woot"
    }

}

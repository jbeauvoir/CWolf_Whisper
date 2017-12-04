//
//  AboutUsViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/28/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setup(){
        //call the class you want to setup the addforum viewcontroller
        print("new UIVIEWCONTROLLER onto stack")
        //let addForum = UIViewController()
        //addForum.view.backgroundColor = UIColor.white
        //addForum.navigationItem.title = setting.name
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        //navigationController?.pushViewController(addForum, animated: true)
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

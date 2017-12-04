//
//  ForumPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/22/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class ForumPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    @IBOutlet weak var MENUBUTTON: UIBarButtonItem!
    @IBAction func MENUBUTTONCLICKED(_ sender: Any) {
        print("Menu button was clicked, calling settingLauncher.revealMenu")
        settingsLauncher.revealMenu()
       // print("came out of setting Launcher class")
    }
    //not using any of these atm
    @IBOutlet weak var homeNavButton: UIBarButtonItem!
    @IBOutlet weak var catNavBoutton: UIBarButtonItem!
    @IBOutlet weak var imNavButton: UIBarButtonItem!
    var forumPageVC: ForumPageViewController?
    
    //let settingLauncher = SettingLauncher()
    lazy var settingsLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.forumPageVC = self
        return launcher
    }()

    /*
    //ot using any of these atm
  //IF WE WANTED TO LET USER TO CLICK TO A CERTAIN TAB, BUT ITS EASY ENOUGH TO SWIPE TO SPOT
    @IBAction func homeClicked(_ sender: Any) {
        //reload data but with home data instead
        //update idx for page controller
        //move page to that spot
    }
    @IBAction func hotClicked(_ sender: Any) {
        //reload connection but with hot topic data instead
        //update idx for page controller
        //move page to that spot
    }
    @IBAction func catClicked(_ sender: Any) {
        //go to category view controller
        //update idx for page controller
        //move page to that spot
    }
   
    @IBAction func imClicked(_ sender: Any) {
        //go to instant message view controller
        //update idx for page controller
        //move page to that spot
    
    }
*/
    
    struct PageWeAreOn {
        static var page:Int = 0
    }
    
    lazy var VCarray: [UIViewController] = {
        return [self.VCinstance(name: "HomeViewController" ),
                self.VCinstance(name: "MessageViewController" ),
                self.VCinstance(name: "CatagoryViewController" )] //These are the storyboard IDs that will be shown on swiping
                                                                //change name to which vieewwcontroller you want
    }()
    var viewController: [UIViewController] = []
    
     func VCinstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //JUST added
        if let navController = self.navigationController {
            viewController = navController.viewControllers as [UIViewController]
        //do changes etc
        }
        self.dataSource = self
        self.delegate = self
        //homeNavButton.tintColor = UIColor.black
        if let firstVC = VCarray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Deletes black bar for pageviewcontroller
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            }
            else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = VCarray.index(of: viewController)
            else {
                return nil
        }
        let prevIndex = viewControllerIndex - 1
        
        guard prevIndex >= 0
            else {
                return VCarray.last
        }
        guard VCarray.count > prevIndex
            else{
                return nil
        }
        
        //whatPageWeAreOn(pageIdx: viewControllerIndex)
        //highlightAndUpdate(pagenumber: viewControllerIndex)//changes color of button on top and updates info if needed

        //setPageNumber(pageIdx: viewControllerIndex)
        //print(prevIndex)
        //highlightAndUpdate(nextSpot: prevIndex)
        return VCarray[prevIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{

        guard let viewControllerIndex = VCarray.index(of: viewController)
            else {
                return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < VCarray.count
            else {
                return VCarray.first
        }
        guard VCarray.count > nextIndex
            else{
                return nil
                
        }
        //setPageNumber(pageIdx: viewControllerIndex)
        //highlightAndUpdate(nextSpot: nextIndex)
        //changes color of button on top and updates info if needed
        return VCarray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        // The number of items reflected in the page indicator.
        return VCarray.count
        
    }
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {// The selected item reflected in the page indicator.
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = VCarray.index(of: firstViewController)
            else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    
    
    func whichSettingButtonWasClicked(stringToCheck: String){
        
        
        if stringToCheck == "" {
            print("error, empty string, Continue")
        }
        else{
           
            if stringToCheck == "App info" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            }
            
            if stringToCheck == "Add New Forum" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            
            }
            if stringToCheck == "Home" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            
            }
            if stringToCheck == "History" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            
            }
            if stringToCheck == "Logout" {
                performSegue(withIdentifier: "ShowAboutInfo", sender: nil)
            
            }
        }
        
    }
    
    func setPageNumber(pageIdx: Int){
       // let viewControllerIndex = VCarray.index(of: viewController)
        PageWeAreOn.page = pageIdx
    }
    
    func getPageNumber()->Int{
        return PageWeAreOn.page
    }
    
    
    func highlightAndUpdate(nextSpot: Int){
        
        //print(nextSpot)
        //update the table view, refresh the connection with what you want. otherwise do nothing and let that ViewController load
        if  nextSpot == 0  {
            homeNavButton.tintColor = UIColor.red
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.white
            //setup home viewTable
            //reset connection to load it
        }
        if nextSpot == 1 {
            homeNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.white
            //setup trending viewTable
            //reset connection to load it
        }
        if nextSpot == 2 {
            homeNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.red
            catNavBoutton.tintColor = UIColor.white
            //setup Cat
            //once they chose a cat, reload home page but with cat restrictions
            //reset connection to load it
        }
        if nextSpot == 3 {
            homeNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.red
            //always reset connection when here
            //setup Chat message board
        }
        
    }
    
}

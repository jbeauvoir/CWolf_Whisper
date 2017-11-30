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
        settingLauncher.revealMenu()
    }
    
    //not using any of these atm
    @IBOutlet weak var homeNavButton: UIBarButtonItem!
    @IBOutlet weak var hotNavButton: UIBarButtonItem!
    @IBOutlet weak var catNavBoutton: UIBarButtonItem!
    @IBOutlet weak var imNavButton: UIBarButtonItem!
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
    
    let settingLauncher = SettingLauncher()
   
    
    struct PageWeAreOn {
        static var whatPageWeAreOn:Int = 0
    }
    
    lazy var VCarray: [UIViewController] = {
        return [self.VCinstance(name: "HomeViewController" ),
                self.VCinstance(name: "HomeViewController" ),
                self.VCinstance(name: "MessageViewController" ),
                self.VCinstance(name: "CatagoryViewController" )] //These are the storyboard IDs that will be shown on swiping
                                                                //change name to which vieewwcontroller you want
    }()
    
     func VCinstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        homeNavButton.tintColor = UIColor.black
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
    
    func whatPageWeAreOn(pageIdx: Int){
        PageWeAreOn.whatPageWeAreOn = pageIdx
    }
    
    func getPageNumber()->Int{
        return PageWeAreOn.whatPageWeAreOn
    }
    
    
    func highlightAndUpdate(){

        
        //update the table view, refresh the connection with what you want. otherwise do nothing and let that ViewController load
        if   getPageNumber() == 0  {
            homeNavButton.tintColor = UIColor.red
            hotNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.white
            //setup home viewTable
            //reset connection to load it
        }
        if getPageNumber() == 1 {
            homeNavButton.tintColor = UIColor.white
            hotNavButton.tintColor = UIColor.red
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.white
            //setup trending viewTable
            //reset connection to load it
        }
        if getPageNumber() == 2 {
            homeNavButton.tintColor = UIColor.white
            hotNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.red
            catNavBoutton.tintColor = UIColor.white
            //setup Cat
            //once they chose a cat, reload home page but with cat restrictions
            //reset connection to load it
        }
        if getPageNumber() == 3 {
            homeNavButton.tintColor = UIColor.white
            hotNavButton.tintColor = UIColor.white
            imNavButton.tintColor = UIColor.white
            catNavBoutton.tintColor = UIColor.red
            //always reset connection when here
            //setup Chat message board
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
        
        //whatPageWeAreOn(pageIdx: getPageNumber())
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
}

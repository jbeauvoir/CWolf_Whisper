//
//  ForumPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/22/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class ForumPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
   
    lazy var VCarray: [UIViewController] = {
        return [self.VCinstance(name: "HomeViewController" ),
                self.VCinstance(name: "HotViewController" ),
                self.VCinstance(name: "MessageViewController" ),
                self.VCinstance(name: "CatagoryViewController" )]
    }()
    
    private func VCinstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
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

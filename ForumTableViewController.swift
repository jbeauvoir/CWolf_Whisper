//
//  ForumTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

//self.tableView.reloadData() USE TO RELOAD TABLES GOING TO NEED SOON

class ForumTableViewController: UITableViewController  {
   // @IBOutlet weak var MenuButton: UIBarButtonItem!
    var useOrNo: Bool = false
    var unusedCells: Int = 0
    var forumsDS: ForumDataSource?
    var downloadAssistant = Download(withURLString: "https://blue.cs.sonoma.edu/~dsmith/")
    let del = UIApplication.shared.delegate as? AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        downloadAssistant.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil) //whenever the data changes on this object or it completes its download Observe
        downloadAssistant.download_request() // store the downloaded
        //were the scoller starts
        self.automaticallyAdjustsScrollViewInsets = false;
        tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(50,0,0,0)
        tableView?.clipsToBounds = true
        //navigationController?.isNavigationBarHidden = true //hide or appear nav bar
        navigationController?.navigationBar.isTranslucent = true;//see through navigation controller
        // self.navigationController?.navigationBar.tintColor = UIColor.white
        //setupNavBarButtons()
    }

    func setPageNumber()->Int{
        var pageNumber = ForumPageViewController.PageWeAreOn.page
        print("WE ARE AT PAGE:  \(pageNumber)")
        return pageNumber
    }
/*
    func setupNavBarButtons() {
       // self.navigationController?.navigationItem.rightBarButtonItems = [MenuButton]
       // self.navigationController?.navigationItem.title = "Home"
        navigationItem.rightBarButtonItems = [MenuButton]
        navigationItem.title = "Home"
    }
*/
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return nil
    }
    
    //size of our tableView Cells hieght
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    var height: CGFloat = 0.0;
    if (useOrNo == true){ //This is setting the cells were not using to a height of 0 essentially hiding them.
        height = 0.0;
    }
    else{
        height = 65.0;
    }
    useOrNo = false
    del?.useCellOrNot = false
    return height;
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(downloadAssistant.dataFromServer!)
        forumsDS = ForumDataSource(dataSource: downloadAssistant.dataFromServer!) //say that the data has been downloaded and is ready to use
        print("ready to use")
        
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    deinit {
        downloadAssistant.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fds = forumsDS { //if data source is set, which is checked in the observationValue
            print(del?.numOfUnusedCells)
            
            return fds.numForums() - (del?.numOfUnusedCells)! 
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumCell", for: indexPath) as! ForumTableViewCell
        if let theCell = cell as? ForumTableViewCell, let forum = forumsDS?.forumAt(indexPath.row) {
            print("calling useforum()")
            theCell.useForum(forum)
            //self.unusedCells = theCell.getUnusednumbers(forum)
            if del?.useCellOrNot == true {
                useOrNo = true
            }
        }
        return cell
    }

    func returnNumberOfCellsNotUsed(count: Int){
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowForumDetails" {
            let cell = sender as! ForumTableViewCell
            if let indexPath = tableView.indexPath(for: cell), let ds = forumsDS {
                let detailedVC = segue.destination as! ForumDetailsViewController
                detailedVC.forumForThisView(ds.forumAt(indexPath.row))
            }
            
        }
    }
}

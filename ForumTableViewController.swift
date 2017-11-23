//
//  ForumTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit


class ForumTableViewController: UITableViewController  {
    @IBOutlet weak var nothingView: UIView!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBAction func clickedMenuButton(_ sender: Any) {
        revealMenu()
    }
   
    
    let settingLauncher = SettingLauncher()
    var forumsDS: ForumDataSource?
    var downloadAssistant = Download(withURLString: "https://blue.cs.sonoma.edu/~dsmith/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = UIColor.white
        downloadAssistant.addObserver(self, forKeyPath: "dataFromServer", options: .old, context: nil) //whenever the data changes on this object or it completes its download Observe
        downloadAssistant.download_request() // store the downloaded
        

        
        ///////
        /*
        navigationController?.navigationBar.isTranslucent = false;
        navigationItem.title = "Home"
        let CGtemp = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: view.frame.width - 32, height: view.frame.height))
        let titleLabel = UILabel(frame: CGtemp)
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
         */
        ////////////
        //were the scoller starts
        //tableView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(50,0,0,0)
  
        //setupBottomMenuBar()
        setupNavBarButtons()
       
    }
   /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 75 //whatever height you want
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        self.navigationController?.navigationBar.tintColor = UIColor.red
     //CHANGE THE HEIGHT OR SIZE OF THE NAVIGATION CONTROLLER
    }
 */
   
    let bottomMenuBar: BottomMenuBar = {
        let menuB = BottomMenuBar()
        return menuB
    }()
    
    func setupBottomMenuBar(){
        
        view.addSubview(bottomMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: bottomMenuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: bottomMenuBar)
        
    }
    
    func setupNavBarButtons() {
        navigationItem.rightBarButtonItems = [MenuButton]
        navigationItem.title = "Home"
    }

    func revealMenu(){
       settingLauncher.revealMenu()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        view.addSubview(bottomMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: bottomMenuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: bottomMenuBar)
        return bottomMenuBar
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
            return fds.numForums()
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForumCell", for: indexPath) as! ForumTableViewCell
        if let theCell = cell as? ForumTableViewCell, let forum = forumsDS?.forumAt(indexPath.row) {
            print("calling useforum()")
            theCell.useForum(forum)
        }
        
        return cell
    }
    
    //size of our tableView Cells hieght
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0;//Choose your custom row height
    }
    
   // func minilinespace

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

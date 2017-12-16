//
//  ForumTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import Firebase
//* ///////////////////////////////////*/
/*https://blue.cs.sonoma.edu/~dsmith/ */
//https://userloginandregistration-3d896.firebaseio.com///userloginandregistration-3d896.firebaseio.com/
//*//////////////////////////////////////*//

class ForumTableViewController: UITableViewController  {

    var useOrNo: Bool = false
    var unusedCells: Int = 0
    let cellId = "cellId"
    var forum = [Forum]()
    let ForumDetailsVC = ForumDetailsViewController()
    let del = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        forumTableVC = self
        self.automaticallyAdjustsScrollViewInsets = true;
        tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(50,0,0,0)
        tableView?.clipsToBounds = true
        navigationController?.navigationBar.isTranslucent = true;//see through navigation controller
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tableView.register(ForumCell.self, forCellReuseIdentifier: cellId)
        fetchForums()
    }
    
    func fetchForums(){
        Database.database().reference().child("Forums").observe(.childAdded, with: { (snapshot) in
            //filters
            let filter: String = (self.del!.whichSettingButtonIClicked)
            let filterbool: Bool = (self.del!.catBool)
            let homefilter: Bool = (self.del!.home)
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let forum = Forum(forum: dictionary)
                if filterbool == false , homefilter == true{
                    self.forum.append(forum)
                }
                if (forum.forumType() == filter) , (filterbool == true){
                self.forum.append(forum)
                }
                //    this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                   self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    func setPageNumber()->Int{
        var pageNumber = ForumPageViewController.PageWeAreOn.page
        print("WE ARE AT PAGE:  \(pageNumber)")
        return pageNumber
    }

    //size of our tableView Cells hieght
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let height = (view.frame.width - 16 - 16) * 9 / 16
       return height - 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forum.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ForumCell
        let forum1 = forum[indexPath.row]
        cell.useForum(forum1)
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    
    var forumDetailsVC: ForumDetailsViewController?
    var forumTableVC: ForumTableViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let forum = self.forum[indexPath.row]
        if let tempForumId = forum.forumID() {
            var tempString: String?
        if let tempForumId2 = forum.getForumID(){
            tempString = tempForumId2 as! String
        }
        del?.forum_idClicked = tempString!
        self.ForumDetailsVC.showChatControllerForUser(forum,forum_id: tempString!)
        self.performSegue(withIdentifier: "ShowForumDetails", sender: self)
    }
    
    func returnNumberOfCellsNotUsed(count: Int){
        
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if del?.initialLoad == true {
            forum.removeAll()
            fetchForums()
        } else {
            super.viewDidAppear(animated)
            forum.removeAll()
            fetchForums()
            self.tableView.reloadData()
            del?.initialLoad = false
        }
    }
    
  

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////*////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ForumCell: UITableViewCell {
    @IBOutlet weak var ForumPicture: UIImageView!
    @IBOutlet weak var subTitleLabelToSet: UILabel!
    @IBOutlet weak var TitleLabelToSet: UILabel!
    @IBOutlet weak var ProfilePictureToSet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var count: Int = 0
    var numOfUnusedCells: Int = 0
    var dontUse: Bool = false

    
      override func prepareForReuse() {
        super.prepareForReuse()
        //ForumPicture.image = nil
        subTitleLabelToSet.text = ""
        TitleLabelToSet.text = ""
        ProfilePictureToSet.image = nil
    }
  

    func useForum(_ forum: Forum) {
      
            //if TitleLabelToSet == nil {
        self.dontUse = false
        let thumbNailImageView = forum.setthumbnailImageView() //UIImageView?
        let userProfilePicture = forum.setuserProfileImage() //UIimage
        let seperateTableView = forum.setseperateTabelView()
        let forumTitleLabel = forum.setforumTitleLabel() //string
        let forumSubTitleLabel = forum.setforumSubTitle()

        if let profileImage = forum.userProfileImage() {
            userProfilePicture?.image = profileImage
        }
        else {
            userProfilePicture?.image = whatIconTouse() // use this to set the icons to each type
        }
        //if let forumPicture = forum.forumPictureImage() {
        //    ProfilePictureToSet.image = forumPicture
       // }
            
       // else {
              //  self.ProfilePictureToSet.image = #imageLiteral(resourceName: "splashScreen")
        //    }
        
        
        if let forumTitle = forum.forumName() {
            forumTitleLabel?.text = forum.userNameForForum()! + " - " + forum.forumName()!
        }

        //setup view and call use data from JSON Object for the sub title of the forum to be set
        if let forumSubTitle = forum.forumSubTitle() {
            forumSubTitleLabel?.text = forumSubTitle
            forumSubTitleLabel?.isUserInteractionEnabled = false
        }
  
  
        addSubview(forumSubTitleLabel!)
        addSubview(thumbNailImageView!)
        addSubview(seperateTableView!)
        addSubview(userProfilePicture!)
        addSubview(forumTitleLabel!)

        var titleLabelHeightConstraint: NSLayoutConstraint?
            
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbNailImageView!)
            
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfilePicture!)
            
            //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbNailImageView!, userProfilePicture!, seperateTableView!)
            
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperateTableView!)
            
            //top constraint
        addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .top, relatedBy: .equal, toItem: thumbNailImageView, attribute: .bottom, multiplier: 1, constant: 4))
            //left constraint
        addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfilePicture, attribute: .right, multiplier: 1, constant: 8))
            //right constraint
        addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
            
            //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: forumTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)
            addConstraint(titleLabelHeightConstraint!)
            
            //top constraint
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .top, relatedBy: .equal, toItem: forumTitleLabel, attribute: .bottom, multiplier: 1, constant: 1))
            //left constraint
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfilePicture, attribute: .right, multiplier: 1, constant: 8))
            //right constraint
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbNailImageView, attribute: .right, multiplier: 1, constant: 0))
            //height constraint
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        subTitleLabelToSet = forumSubTitleLabel
        TitleLabelToSet = forumTitleLabel
        ProfilePictureToSet = userProfilePicture
        subTitleLabelToSet.sizeToFit()
        subTitleLabelToSet.numberOfLines = 2
        TitleLabelToSet.sizeToFit()
        TitleLabelToSet.numberOfLines = 2
        forumTitleLabel?.clipsToBounds = true
        forumSubTitleLabel?.clipsToBounds = true
        forumTitleLabel?.sizeToFit()
        //forumTitleLabel?.numberOfLines = 0
        thumbNailImageView?.clipsToBounds = true
        thumbNailImageView?.sizeToFit()
        seperateTableView?.clipsToBounds = true
        seperateTableView?.sizeToFit()
      //  }
    }//

func getUnusednumbers(_ forum: Forum)->Int{
    return forum.returnNumberOfCellsNotUsed()
    
}

   func whatIconTouse() ->UIImage {
    let image: UIImage
    let stringToCheck: String = (del?.whichSettingButtonIClicked)!
    
    if stringToCheck == "" {
        image = #imageLiteral(resourceName: "splashScreen")
        print("error, empty string, Continue")
         return image
    }
    else{
        
        if stringToCheck == "social" {
           image = #imageLiteral(resourceName: "social")
             return image
        }
        if  stringToCheck == "sports" {
            image = #imageLiteral(resourceName: "sports")
             return image
        }
        if  stringToCheck == "help" {// complete
            image = #imageLiteral(resourceName: "info2")
             return image
        }
        if  stringToCheck == "jokes" { //complete
            image = #imageLiteral(resourceName: "jokes")
             return image
        }
        if   stringToCheck == "school" { //complete
           image = #imageLiteral(resourceName: "school")
             return image
        }
        if  stringToCheck == "buySell" { //complete
            image = #imageLiteral(resourceName: "Home")
             return image
        }
        
        image = #imageLiteral(resourceName: "splashScreen")
         return image
    }
}
}


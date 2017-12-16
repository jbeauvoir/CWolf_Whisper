//
//  CommentTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentTableViewController: UITableViewController { // START CLASS
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBAction func MenuButtonClicked(_ sender: Any) {
       // revealMenu()
    }

    // VARIABLES
    // @IBOutlet weak var MenuButton: UIBarButtonItem!
    var useOrNo: Bool = false
    var unusedCells: Int = 0
    let cellId = "cellId"
    var comment = [Comment]()
    let del = UIApplication.shared.delegate as? AppDelegate
    //var downloadAssistant = Download(withURLString: "https://blue.cs.sonoma.edu/~dsmith/")
    ////////////////////////////////////////////
    
    
    // VIEW DID LOAD START
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true;
        //tableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //tableView?.scrollIndicatorInsets = UIEdgeInsetsMake(-10,0,0,0)
        tableView?.clipsToBounds = true
        //navigationController?.isNavigationBarHidden = true //hide or appear nav bar
        navigationController?.navigationBar.isTranslucent = true;//see through navigation controller
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //setupNavBarButtons()
        
        tableView.register(CommentCell.self, forCellReuseIdentifier: cellId)
       // fetchComments()
    }
    // VIEW DID LOAD END
    
    /*
    func fetchComments(){
        Database.database().reference().child("Forums").child(unique_id).child("comments").observeSingleEvent(of: .value, with: { (DataSnapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let comment = Comment(comment: dictionary)
                self.comment.append(comment)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        } , withCancel: nil)
    }
    */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return nil
    }
    /*
    //size of our tableView Cells hieght
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0;
        if (useOrNo == true){ //This is setting the cells were not using to a height of 0 essentially hiding them.
            height = 0.0;
        }
        else{
            height = 72;
        }
        useOrNo = false
        del?.useCellOrNot = false
        return height;
    } */
    /*
     override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
     print(downloadAssistant.dataFromServer!)
     forumsDS = ForumDataSource(dataSource: downloadAssistant.dataFromServer!) //say that the data has been downloaded and is ready to use
     print("ready to use")
     
     
     DispatchQueue.main.async(execute: {
     self.tableView.reloadData()
     })
     }
     */
    /*
    deinit {
        downloadAssistant.removeObserver(self, forKeyPath: "dataFromServer", context: nil)
    }
    */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if let fds = forumsDS { //if data source is set, which is checked in the observationValue
        //   print(del?.numOfUnusedCells)
        return comment.count
        //   return fds.numForums() - (del?.numOfUnusedCells)!
        //  }
        // return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CommentCell
        
        let comment1 = comment[indexPath.row]
        // cell.textLabel?.text = forum1.forumName1
        //cell.detailTextLabel?.text = forum1.forumsubtitle1
        
        
        cell.useComment(comment1)
        //  if let profileImageUrl = forum1.profileImageUrl {
        //    cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        // }
        
        return cell
    }
    
    
    //var forumDetailsVC: ForumDetailsViewController?
    var commentTableVC: CommentTableViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // dismiss(animated: true) {
          //  print("Dismiss completed")
       // }
        let comment = self.comment[indexPath.row]
        //let forumDetails = ForumDetailsViewController()
        // self.forumTableVC?.forum = [forum]
        //self.commentTableVC.showChatControllerForUser(comment)
        
        
        
        //self.forumDetailsVC?.showDetailsForUser(forum)
        self.performSegue(withIdentifier: "ShowComments", sender: self)
        // self.forumDetailsVC?.showDetailsVC(forum)
    }
    
    func returnNumberOfCellsNotUsed(count: Int){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowComments" {
            performSegue(withIdentifier: "ShowComments", sender: nil)
            
            /*
             let cell = sender as! ForumTableViewCell
             if let indexPath = tableview.indexPath(for: cell), let forumT = forum {
             let detailedVC = segue.destination as! ForumDetailsViewController
             detailedVC.forimForThisView(ds.forumAt(indexPath.row))
             }*/
            //let forum = self.forum[indexPath.row]
              //if let indexPath = tableView.indexPath(for: cell) {
            //  let detailedVC = segue.destination as! ForumDetailsViewController
              //  detailedVC.forumForThisView(ForumCell.forumAt(indexPath.row))
      //  }
 
    
            }
    }
 
}


class CommentCell: UITableViewCell {
   // @IBOutlet weak var cellImage: UIImageView!
   // @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var CcellImage: UIImageView!
    @IBOutlet weak var cellBody: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    var count: Int = 0
    var numOfUnusedCells: Int = 0
    var dontUse: Bool = false
    
    override func layoutSubviews() {
        func setupViews() {
            
        }
        super.layoutSubviews()
        
        
    }
  
    /*
     let profileImageView: UIImageView = {
     let imageView = UIImageView()
     imageView.translatesAutoresizingMaskIntoConstraints = false
     imageView.layer.cornerRadius = 24
     imageView.layer.masksToBounds = true
     imageView.contentMode = .scaleAspectFill
     return imageView
     }()*/
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func useComment(_ comment: Comment) {
        /////
        // cell.textLabel?.text = forum1.forumName1
        //cell.detailTextLabel?.text = forum1.forumsubtitle1
        self.dontUse = false
        
        //not really using but need for contraints
        
        //let thumbNailImageView = forum.setthumbnailImageView() //UIImageView?
        let commentCreator = comment.commentCreatorName()
        let commentBody = comment.commentBody() //UIimage
        let seperateTableView = comment.setseperateTabelView()
        let image = comment.getImage()
        //let commentTitleLabel = comment.setforumTitleLabel() //string
        //let forumSubTitleLabel = comment.setforumSubTitle()
        
        
        if let profileImage = comment.getImage() {
            CcellImage?.image = profileImage
        }
        else {
            CcellImage?.image = #imageLiteral(resourceName: "chat")
            
        }
  
        //setup view and call use data from JSON Object for the sub title of the forum to be set
        if let commentB = image{
            //commentB.image = comment.getImage1
            //commentB.isUserInteractionEnabled = false
        }
        
        //addSubview(forumSubTitleLabel!)
        addSubview(CcellImage!)
        addSubview(seperateTableView!)
        //addSubview(commentB!)
       // addSubview(forumTitleLabel!)
        
      // forumTitleLabel?.clipsToBounds = true
      //  forumSubTitleLabel?.clipsToBounds = true
        
        ////////
        //adding Contraints to the ForumTableView
        //////////
        addConstraintsWithFormat(format: "H:|[v0]|", views: CcellImage!)
        addConstraintsWithFormat(format: "V:|[v0(1)]|", views: CcellImage!)
     //   addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfilePicture!)
        //verticle constraintss
     //   addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: cellImage!,userProfilePicture!,seperateTableView!)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperateTableView!)
     //   addConstraintsWithFormat(format: "V:[v0(20)]", views: forumTitleLabel!)
        
      //  var titleLabelHeightConstraint: NSLayoutConstraint?
        //////top
      //  addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .top, relatedBy: .equal, toItem: cellImage, attribute: .bottom, multiplier: 1, constant: 8))
        //left
     //   addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfilePicture, attribute: .right, multiplier: 1, constant: 8))
        //right
       // addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .right, relatedBy: .equal, toItem: cellImage, attribute: .right, multiplier: 1, constant: 0))
        //height
       // titleLabelHeightConstraint = NSLayoutConstraint(item: forumTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
       // addConstraint(titleLabelHeightConstraint!)
        //////////////////////////
        //top
        //addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .top, relatedBy: .equal, toItem: forumTitleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left
       // addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfilePicture, attribute: .right, multiplier: 1, constant: 8))
        //right
       // addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .right, relatedBy: .equal, toItem: forumTitleLabel, attribute: .right, multiplier: 1, constant: 0))
        
       // addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        //////
 
    }
    //
}





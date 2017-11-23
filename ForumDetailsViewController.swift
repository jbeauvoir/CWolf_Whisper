//
//  ForumDetailsViewController.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class ForumDetailsViewController: UIViewController {
    @IBOutlet weak var forumBodyLabel: UILabel!
    @IBOutlet weak var ForumPicture: UIImageView!
    @IBOutlet weak var ForumTitle: UILabel!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var CommentButton: UIButton!
    @IBOutlet weak var NumOfCommentsLabel: UILabel!
    @IBOutlet weak var NumOfLikesLabel: UILabel!
    @IBOutlet weak var likedView: UIImageView!
    @IBOutlet weak var MenuButton: UIBarButtonItem!
    @IBAction func MenuButtonClicked(_ sender: Any) {
        revealMenu()
    }
    
    let settingLauncher = SettingLauncher()
    var numberOfLikesForForum = 0 // needs to become a DB item
    var forum: Forum?
    
    func revealMenu(){
        settingLauncher.revealMenu()
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
         likedView.isHidden = false //set a boolean so that that user cant see again next time they return
        //Add functionality if the button is pressed change the color and save the state for that user/ let them not click again
        //add update how manny likes the forum has
        //updateLikesForForum()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        likedView.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let f = forum {
           
            let ammountOfcomments: String
            ammountOfcomments =  String(describing: f.numberOfComments()!)
            self.NumOfCommentsLabel.text = ammountOfcomments
            
            let likes: String
            likes =  String(describing: f.numberOfLikes()!)
            self.NumOfLikesLabel.text = likes
            self.forumBodyLabel.text = f.forumBody()
            
            if let forumTitleLabel = f.forumName() {
                ForumTitle.text = f.userNameForForum()! + " - " + forumTitleLabel
            }
            //if there was an image for the Forum add it otherwise delete that view and move up text
            if let forumPictureThere = f.getImage(){
                ForumPicture.image = forumPictureThere
            }
            else {
                self.ForumPicture.removeFromSuperview()
                let CGrectForBodyLabel = CGRect(origin: CGPoint(x: 20,y :150), size: CGSize(width: 500, height: 700))
                forumBodyLabel.frame = CGrectForBodyLabel
            }
            
             //make it so it expand over manny lines
            forumBodyLabel.lineBreakMode = .byWordWrapping
            forumBodyLabel.numberOfLines = 0
            forumBodyLabel.sizeToFit()
            }
        
    }
    
    func forumForThisView(_ forum: Forum) {
        self.forum = forum
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

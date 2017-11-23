//
//  ForumTableViewCell.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/11/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit


//This Class sets up are table and its cells, adds views and constraints

class ForumTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func useForum(_ forum: Forum) {
       if let aImage = forum.getImage()  {
            cellImage.image = aImage
        }
        //not really using but need for contraints
        let thumbnailImageView = forum.setthumbnailImageView()
        addSubview(thumbnailImageView!)
        let seperateTableView = forum.setseperateTabelView()
        addSubview(seperateTableView!)
        
        let userProfileImage = forum.setuserProfileImage()
        if let profileImage = forum.userProfileImage() {
            userProfileImage?.image = profileImage
        }
        addSubview(userProfileImage!)
       
        //set up the view and use data from JSON Object for the title of the forum to be set
         let forumTitleLabel = forum.setforumTitleLabel()
        if let forumTitle = forum.forumName() {
        forumTitleLabel.text = forum.userNameForForum()! + " - " + forumTitle
        }
        addSubview(forumTitleLabel)

        //setup view and call use data from JSON Object for the sub title of the forum to be set
        let forumSubTitleLabel = forum.setforumSubTitle()
        if let forumSubTitle = forum.forumSubTitle() {
            forumSubTitleLabel.text = forumSubTitle
            forumSubTitleLabel.isUserInteractionEnabled = false
        }
        addSubview(forumSubTitleLabel)
        
        ////////
        //adding Contraints to the ForumTableView
        //////////
        addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailImageView!)
        addConstraintsWithFormat(format: "V:|[v0(1)]|", views: thumbnailImageView!)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImage!)
        //verticle constraintss
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView!,userProfileImage!,seperateTableView!)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperateTableView!)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: forumTitleLabel)

        //////top
        addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left
         addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        //right
         addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height
         addConstraint(NSLayoutConstraint(item: forumTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //////////////////////////
        //top
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .top, relatedBy: .equal, toItem: forumTitleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        //right
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .right, relatedBy: .equal, toItem: forumTitleLabel, attribute: .right, multiplier: 1, constant: -50))
        
        addConstraint(NSLayoutConstraint(item: forumSubTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
       //////
        
    }
  
    func setupViews(){
        print("weGotHere ON Mistake")
    }
}

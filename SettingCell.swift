//
//  SettingCell.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/13/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit


class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {//if they hold the click don set the label images etc
        didSet{
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.white
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.rgb(red: 131, green: 177, blue: 255)
            iconImageView.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.rgb(red: 131, green: 177, blue: 255)
        }
    }
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.white
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.rgb(red: 131, green: 177, blue: 255)
            iconImageView.backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.rgb(red: 131, green: 177, blue: 255)
        }
    }
    var setting: Setting?{
        didSet{
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        
        }
        
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addForumButton")
        return imageView
    }()

    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        backgroundColor = UIColor.rgb(red: 131, green: 177, blue: 255)
        nameLabel.textColor = UIColor.white
        
        addConstraintsWithFormat(format:"H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format:"V:|[v0]|", views: nameLabel)
        
        addConstraintsWithFormat(format:"V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    
}

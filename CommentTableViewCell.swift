//
//  CommentTableViewCell.swift
//  UserLoginAndRegistration
//
//  Created by student on 11/12/17.
//  Copyright © 2017 team SeaWolfWhisper. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var CellCommentImage: UIImageView!
    @IBOutlet weak var cellCommentLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func useComment(_ comment: Comment) {
            if let aImage = comment.getImage()  {
                CellCommentImage.image = aImage
                
            }
            cellCommentLabel.text = comment.commentBody()
        }
        // Configure the view for the selected state
    

}

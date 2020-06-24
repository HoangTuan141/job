//
//  CommentTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/9/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: CommentDetailRecruitmentPost) {
        contentLabel.text = data.content
        nameLabel.text = data.userName
    }
    
    func fillData(data: CommentDetailPostFindJob) {
        contentLabel.text = data.content
        nameLabel.text = data.userName
    }
    
}

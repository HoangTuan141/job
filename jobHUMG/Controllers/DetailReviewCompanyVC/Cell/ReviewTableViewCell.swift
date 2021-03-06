//
//  ReviewTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/15/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    
    var onTapLikeButton: (() -> Void)?
    var onTapDisLikeButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(data: CommentReview) {
        nameLabel.text = data.reviewName
        ratingView.rating = Double(data.star)
        timeLabel.text = data.createdAt.dateFromTimestamp.toString(formatter: .dayMonthYear)
        contentLabel.text = data.reviewContent
        likeLabel.text = "\(data.likeCount)"
        dislikeLabel.text = "\(data.disLikeCount)"
    }
    
    @IBAction func likePressed(_ sender: Any) {
        self.onTapLikeButton?()
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        self.onTapDisLikeButton?()
    }
    
}

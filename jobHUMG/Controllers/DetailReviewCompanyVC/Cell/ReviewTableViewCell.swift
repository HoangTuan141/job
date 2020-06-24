//
//  ReviewTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/15/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Cosmos

protocol ReviewTableCellDelegate: class {
    func onClickLike()
    func onClickDislike()
}

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    
    weak var delegate: ReviewTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
    
    }
    
    @IBAction func likePressed(_ sender: Any) {
        self.delegate?.onClickLike()
    }
    
    @IBAction func dislikePressed(_ sender: Any) {
        self.delegate?.onClickDislike()
    }
    
}

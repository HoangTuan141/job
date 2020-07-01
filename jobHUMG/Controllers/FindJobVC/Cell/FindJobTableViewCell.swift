//
//  FindJobTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/8/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class FindJobTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconLikeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    // MARK: - Property
    var isHiddenSeparator: Bool? {
        didSet {
            separator.isHidden = self.isHiddenSeparator ?? true ? true : false
        }
    }
    
    var tapMoreButton: (() -> Void)?
    var tapLikeButton: (() -> Void)?
    var tapCommentButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLikeButton(isLike: Bool) {
        iconLikeImage.image = isLike ? #imageLiteral(resourceName: "ic_like_selected") : #imageLiteral(resourceName: "ic_like")
        likeLabel.textColor = isLike ? UIColor.greenMainColor : UIColor.grayColor
    }
    
    // MARK: - Action
    @IBAction func likePressed(_ sender: Any) {
        self.tapLikeButton?()
    }
    
    @IBAction func commentPressed(_ sender: Any) {
        self.tapCommentButton?()
    }
    
    @IBAction func morePressed(_ sender: Any) {
        self.tapMoreButton?()
    }
}

extension FindJobTableViewCell {
    func fillData(data: DataListPostFindJob) {
//        avatarImage.image = UIImage(named: data.userAvatar)
        nameLabel.text = data.userName
        timeLabel.text = data.createdAt.dateFromTimestamp.toString(formatter: .dayMonthYear)
        careerLabel.text = data.career
        addressLabel.text = data.location
        descriptionLabel.text = data.description
        likeLabel.text = "\(data.likeCount)"
        commentLabel.text = "\(data.commentCount)"
        setupLikeButton(isLike: data.isLike)
    }
    
    func fillData(data: DataDetailPostFindJob) {
//        avatarImage.image = UIImage(named: data.userAvatar)
        nameLabel.text = data.userName
        timeLabel.text = data.createdAt.dateFromTimestamp.toString(formatter: .dayMonthYear)
        careerLabel.text = data.career
        addressLabel.text = data.location
        descriptionLabel.text = data.description
        likeLabel.text = "\(data.likeCount)"
        commentLabel.text = "\(data.commentCount)"
        setupLikeButton(isLike: data.isLike)
    }
}

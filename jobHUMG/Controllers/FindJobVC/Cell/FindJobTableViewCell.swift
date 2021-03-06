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
    @IBOutlet weak var expiredLabel: UILabel!
    
    // MARK: - Property
    var isHiddenSeparator: Bool? {
        didSet {
            separator.isHidden = self.isHiddenSeparator ?? true ? true : false
        }
    }
    
    var tapGoToUserInfo: (() -> Void)?
    var tapLikeButton: (() -> Void)?
    var tapCommentButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToUserInfo))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func goToUserInfo() {
        self.tapGoToUserInfo?()
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
    
    @IBAction func goToUserInfoPressed(_ sender: Any) {
        self.tapGoToUserInfo?()
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
        
        expiredLabel.isHidden = data.endDateTime < Date().timeStamp ?? 0 ? false : true
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
        
        expiredLabel.isHidden = data.endDateTime < Date().timeStamp ?? 0 ? false : true
    }
}

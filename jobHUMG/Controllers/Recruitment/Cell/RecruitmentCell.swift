//
//  RecruitmentCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/6/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class RecruitmentCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconLikeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var expiredLabel: UILabel!
    
    var isHiddenSeparator: Bool? {
        didSet {
            separator.isHidden = self.isHiddenSeparator ?? true ? true : false
        }
    }
    
    var tapLikeButton: (() -> Void)?
    var tapCommentButton: (() -> Void)?
    var tapGoToUserInfo: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToUserInfo))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func userInfoPressed(_ sender: Any) {
        self.tapGoToUserInfo?()
    }
    
    @objc func goToUserInfo() {
        self.tapGoToUserInfo?()
    }
    
    func setupLikeButton(isLike: Bool) {
        iconLikeImage.image = isLike ? #imageLiteral(resourceName: "ic_like_selected") : #imageLiteral(resourceName: "ic_like")
        likeLabel.textColor = isLike ? UIColor.greenMainColor : UIColor.grayColor
    }
    
    @IBAction func likePressed(_ sender: Any) {
        self.tapLikeButton?()
    }
    
    @IBAction func commentPressed(_ sender: Any) {
        self.tapCommentButton?()
    }
}

extension RecruitmentCell {
    func fillData(data: DataListRecruitmentPost) {
//        avatarImage.image = UIImage(named: data.userAvatar)
        nameLabel.text = data.userName
        timeLabel.text = data.createdAt.dateFromTimestamp.toString(formatter: .dayMonthYear)
        careerLabel.text = data.career
        companyNameLabel.text = data.companyName
        salaryLabel.text = data.wage
        addressLabel.text = data.location
        descriptionLabel.text = data.description
        likeLabel.text = "\(data.likeCount)"
        commentLabel.text = "\(data.commentCount)"
        setupLikeButton(isLike: data.isLike)
        
        expiredLabel.isHidden = data.endDateTime < Date().timeStamp ?? 0 ? false : true
    }
    
    func fillDataDetail(data: DataDetailRecruitmentPost) {
//        avatarImage.image = UIImage(named: data.userAvatar)
        nameLabel.text = data.userName
        timeLabel.text = data.createdAt.dateFromTimestamp.toString(formatter: .dayMonthYear)
        careerLabel.text = data.career
        companyNameLabel.text = data.companyName
        salaryLabel.text = data.wage
        addressLabel.text = data.location
        descriptionLabel.text = data.description
        likeLabel.text = "\(data.likeCount)"
        commentLabel.text = "\(data.commentCount)"
        setupLikeButton(isLike: data.isLike)
        
        expiredLabel.isHidden = data.endDateTime < Date().timeStamp ?? 0 ? false : true
    }
}

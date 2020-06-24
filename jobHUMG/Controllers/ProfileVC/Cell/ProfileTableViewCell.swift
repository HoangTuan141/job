//
//  ProfileTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/16/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

protocol ProfileTableViewCellDelegate: class {
    func onClickEditProfile()
    func onClickLogOut()
}

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var skypeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    
    // MARK: - Property
    weak var delegate: ProfileTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        self.delegate?.onClickLogOut()
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        self.delegate?.onClickEditProfile()
    }
    
}

//
//  ReviewCompanyCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/13/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class ReviewCompanyCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.isUserInteractionEnabled = false
    }
    
    func setupCell(data: DataListCompany) {
        companyImage.kf.setImage(with: URL(string: data.avatar))
        companyNameLabel.text = data.name
        ratingView.rating = Double(data.ratingStar)
        ratingView.text = "(\(data.ratingCount))"
        careerLabel.text = data.career
        locationLabel.text = data.address
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

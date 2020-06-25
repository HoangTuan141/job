//
//  SearchCompanyTableCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/15/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCompanyTableCell: UITableViewCell {
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data: DataSearchCompany) {
        companyImage.kf.setImage(with: URL(string: data.avatar))
        companyNameLabel.text = data.name
    }
}

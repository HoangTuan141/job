//
//  CareerTableViewCell.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class CareerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func fillData(career: String) {
        titleLabel.text = career
    }
    
}

//
//  MaritalStatusPopup.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/26/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

enum Marital {
    case none
    case single
    case married
    
    var titleString: String {
        switch self {
        case .none:
            return "dd/MM/yyyy"
        case .single:
            return "Độc thân"
        case .married:
            return "Đã kết hôn"
        }
    }
}

class MaritalStatusPopup: UIViewController {

    @IBOutlet weak var iconIsSelectedSingle: UIImageView!
    @IBOutlet weak var iconIsSelectedMarried: UIImageView!
    
    var status: Marital = .none
    var selected: ((_ status: Marital) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if status == .single {
            iconIsSelectedSingle.image = #imageLiteral(resourceName: "icon_mark")
        } else if status == .married {
            iconIsSelectedMarried.image = #imageLiteral(resourceName: "icon_mark")
        } else {
            iconIsSelectedSingle.image = nil
            iconIsSelectedMarried.image = nil
        }
    }

    @IBAction func singlePressed(_ sender: Any) {
        status = .single
        self.selected?(status)
        self.dismiss(animated: false, completion: nil)
    }
    
  
    @IBAction func marriedPressed(_ sender: Any) {
        status = .married
        self.selected?(status)
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

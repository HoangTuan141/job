//
//  ListCompanyReviewAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/24/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseListCompany: Response {
    var data =  [DataListCompany]()
    
    init(json: JSON) {
        if let listCompany = json["data"].array {
            for company in listCompany {
                self.data.append(DataListCompany(json: company))
            }
        }
    }
}

struct DataListCompany: Response {
    var id: Int?
    var name: String
    var address: String
    var career: String
    var avatar: String
    var ratingStar: Int
    var ratingCount: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.address = json["address"].stringValue
        self.career = json["career"].stringValue
        self.avatar = json["avatar"].stringValue
        self.ratingStar = json["rating_star"].intValue
        self.ratingCount = json["rating_count"].intValue
    }
}

class ListCompanyReviewAPI: APIService<ResponseListCompany> {
    init() {
        super.init(request: APIRequest(name: "Get list company review",
                                       path: "api/review/company",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

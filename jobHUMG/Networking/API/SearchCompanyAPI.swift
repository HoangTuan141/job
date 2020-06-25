//
//  SearchCompanyAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/25/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseSearchCompany: Response {
    var data = [DataSearchCompany] ()
    
    init(json: JSON) {
        if let listCompany = json["data"].array {
            for company in listCompany {
                self.data.append(DataSearchCompany(json: company))
            }
        }
    }
}

struct DataSearchCompany: Response {
    var id: Int
    var name: String
    var avatar: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["avatar"].stringValue
    }
}

class SearchCompanyAPI: APIService<ResponseSearchCompany> {
    init(name: String) {
        super.init(request: APIRequest(name: "Search Company API",
                                       path: "api/review/search?name=\(name)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

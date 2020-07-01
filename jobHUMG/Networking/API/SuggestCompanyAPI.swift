//
//  SuggestCompanyAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/1/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseSuggestCompany: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class SuggestCompanyAPI: APIService<ResponseSuggestCompany> {
    init(name: String, address: String, career: String) {
        let params = ["name": name,
                      "address": address,
                      "career": career]
        super.init(request: APIRequest(name: "Suggest Company API",
                                       path: "api/review/company",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}

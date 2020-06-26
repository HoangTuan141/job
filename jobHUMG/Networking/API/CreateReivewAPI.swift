//
//  CreateReivewAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/26/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseCreateReview: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class CreateReviewAPI: APIService<ResponseCreateReview> {
    init(name: String, content: String, id: Int, star: Int) {
        let params = ["review_name": name,
                      "review_content": content,
                      "company_id": id,
                      "star": star] as [String : Any]
        super.init(request: APIRequest(name: "Create Review API",
                                       path: "api/review/create-review",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}


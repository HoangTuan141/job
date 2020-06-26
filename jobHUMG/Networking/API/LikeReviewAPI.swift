//
//  LikeReviewAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/26/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseLikeReview: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class LikeReviewAPI: APIService<ResponseLikeReview> {
    init(id: Int) {
        super.init(request: APIRequest(name: "Like Review API",
                                       path: "api/review/like-comment/\(id)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

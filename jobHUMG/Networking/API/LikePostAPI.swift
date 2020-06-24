//
//  LikePostAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/23/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseLikePost: Response {
    var error: String
    var message: String
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class LikePostAPI: APIService<ResponseLikePost> {
    init(id: Int) {
        super.init(request: APIRequest(name: "Like Post API",
                                       path: "api/post/like/\(id)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

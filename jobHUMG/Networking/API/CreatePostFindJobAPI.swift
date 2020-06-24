//
//  CreatePostFindJobAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/23/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseCreatePostFindJob: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class CreatePostFindJobAPI: APIService<ResponseCreatePostFindJob> {
    init(career: String, location: String, description: String, startDate: Int, endDate: Int) {
        let params = ["career": career,
                      "location": location,
                      "description": description,
                      "startDatetime": startDate,
                      "endDatetime": endDate] as [String : Any]
        super.init(request: APIRequest(name: "Create post find job",
                                       path: "api/post/member",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}

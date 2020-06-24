//
//  CreatePostRecruitmentAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/22/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseCreateRecruitmentPost: Response {
    var errors: String
    var message: String
    
    init(json: JSON) {
        self.errors = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class CreateRecruitmentPost: APIService<ResponseCreateRecruitmentPost> {
    init(carrer: String, companyName: String, salary: String, location: String, description: String, startDate: Int, endDate: Int) {
        let params = [ "career": carrer,
                      "company_name": companyName,
                      "wage": salary,
                      "location": location,
                      "description": description,
                      "startDatetime": startDate,
                      "endDatetime": endDate ] as [String : Any]
        super.init(request: APIRequest(name: "Create recruitment post",
                                       path: "api/post/employer",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}

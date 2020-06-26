//
//  UpdateUserInfoAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/26/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseUpdateUserInfo: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class UpdateUserInfoAPI: APIService<ResponseUpdateUserInfo> {
    init(fullName: String, birthday: String, phone: String, skype: String, marital: String, hobby: String, avatar: String?, career: String, introduce: String) {
        var params = ["full_name": fullName,
                      "birthday": birthday,
                      "phone_number": phone,
                      "skype": skype,
                      "marital": marital,
                      "hobby": hobby,
                      "sub_name": career,
                      "sort_description": introduce]
        
        if let avatar = avatar {
            params.updateValue(avatar, forKey: "avatar")
        }
        
        super.init(request: APIRequest(name: "Update UserInfo API",
                                       path: "api/auth/user-detail",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}

//
//  LoginAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/16/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseLogin: Response {
    var error: Bool
    var token: String
    
    init(json: JSON) {
        self.error = json["errors"].boolValue
        self.token = json["token"].stringValue
    }
}

class LoginAPI: APIService<ResponseLogin> {
    init(email: String, password: String ) {
        let params = ["email": email,
                      "password": password]
        super.init(request: APIRequest(name: "Login API",
                                       path: "api/auth/login",
                                       method: .post,
                                       parameters: params))
    }
}


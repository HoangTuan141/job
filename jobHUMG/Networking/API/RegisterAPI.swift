//
//  RegisterAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/16/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseRegister: Response {
    var error: String
    var data: ResponseDataRegister
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.data = ResponseDataRegister(json: json["data"])
    }
}

struct ResponseDataRegister: Response {
    var email: String
    var firstName: String
    var lastName: String
    var isMobile: Bool
    var updatedAt: String
    var createdAt: String
    var id: Int
    init(json: JSON) {
        self.email = json["email"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.isMobile = json["is_mobile"].boolValue
        self.updatedAt = json["updated_at"].stringValue
        self.createdAt = json["created_at"].stringValue
        self.id = json["id"].intValue
    }
}

class RegisterAPI: APIService<ResponseRegister> {
    init(email: String, password: String, firstName: String, lastName: String) {
        let params = ["email": email,
                      "password": password,
                      "first_name": firstName,
                      "last_name": lastName]
        super.init(request: APIRequest(name: "API Register",
                                       path: "api/auth/register",
                                       method: .post,
                                       parameters: params))
    }
}

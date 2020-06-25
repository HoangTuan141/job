//
//  UserInformationAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/24/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseUserInformation: Response {
    var data: DataUserInformation?
    init(json: JSON) {
        self.data = DataUserInformation(json: json["data"])
    }
}

struct DataUserInformation: Response {
    var id: Int
    var fullName: String
    var birthday: String
    var phoneNumber: String
    var skype: String
    var email: String
    var martial: String
    var hobby: String
    var avatar: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.fullName = json["full_name"].stringValue
        self.birthday = json["birthday"].stringValue
        self.phoneNumber = json["phone_number"].stringValue
        self.skype = json["skype"].stringValue
        self.email = json["email"].stringValue
        self.martial = json["marital"].stringValue
        self.hobby = json["hobby"].stringValue
        self.avatar = json["avatar"].stringValue
    }
}

class GetUserInformationAPI: APIService<ResponseUserInformation> {
    init() {
        super.init(request: APIRequest(name: "Get User Information API",
                                       path: "api/auth/user-detail",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

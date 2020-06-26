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
    var marital: String
    var hobby: String
    var avatar: String
    var career: String
    var introduce: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.fullName = json["full_name"].stringValue
        self.birthday = json["birthday"].stringValue
        self.phoneNumber = json["phone_number"].stringValue
        self.skype = json["skype"].stringValue
        self.email = json["email"].stringValue
        self.marital = json["marital"].stringValue
        self.hobby = json["hobby"].stringValue
        self.avatar = json["avatar"].stringValue
        self.career = json["sub_name"].stringValue
        self.introduce = json["sort_description"].stringValue
    }
    
    init(id: Int, fullName: String, birthday: String, phoneNumber: String, skype: String, email: String, marital: String, hobby: String, avatar: String, career: String, introduce: String) {
        self.id = id
        self.fullName = fullName
        self.birthday = birthday
        self.phoneNumber = phoneNumber
        self.skype = skype
        self.email = email
        self.marital = marital
        self.hobby = hobby
        self.avatar = avatar
        self.career = career
        self.introduce = introduce
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

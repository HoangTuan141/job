//
//  UserManager.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/26/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    func checkUserInfo() -> Bool {
        if SharedData.fullName != "" && SharedData.fullName != nil &&
            SharedData.birthday != "" && SharedData.birthday != nil &&
            SharedData.phoneNumber != "" && SharedData.phoneNumber != nil &&
            SharedData.skype != "" && SharedData.skype != nil &&
            SharedData.email != "" && SharedData.email != nil &&
            SharedData.martial != "" && SharedData.martial != nil &&
            SharedData.hobby != "" && SharedData.hobby != nil &&
            SharedData.career != "" && SharedData.career != nil  {
            return true
        } else {
            return false
        }
    }
    
    func saveUserInfo(data: DataUserInformation) {
        SharedData.id = data.id
        SharedData.fullName = data.fullName
        SharedData.birthday = data.birthday
        SharedData.phoneNumber = data.phoneNumber
        SharedData.skype = data.skype
        SharedData.email = data.email
        SharedData.martial = data.marital
        SharedData.hobby = data.hobby
        SharedData.avatar = data.avatar
        SharedData.career = data.career
        SharedData.introduce = data.introduce
    }
    
    var userInfo: DataUserInformation? {
        return DataUserInformation(id: SharedData.id ?? 0,
                                   fullName: SharedData.fullName ?? "",
                                   birthday: SharedData.birthday ?? "",
                                   phoneNumber: SharedData.phoneNumber ?? "",
                                   skype: SharedData.skype ?? "",
                                   email: SharedData.email ?? "",
                                   marital: SharedData.martial ?? "",
                                   hobby: SharedData.hobby ?? "",
                                   avatar: SharedData.avatar ?? "",
                                   career: SharedData.career ?? "",
                                   introduce: SharedData.introduce ?? "")
    }
}

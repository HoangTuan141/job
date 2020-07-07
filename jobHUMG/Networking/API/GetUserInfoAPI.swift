//
//  GetUserInfoAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/6/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetUserInfoAPI: APIService<ResponseUserInformation> {
    init(id: Int) {
        super.init(request: APIRequest(name: "Get User \(id) Info API",
                                       path: "api/auth/user-info/\(id)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

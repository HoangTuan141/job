//
//  NetworkService.swift
//  Mock
//
//  Created by TuanHA-D1 on 12/25/19.
//  Copyright © 2019 TuanHA-D1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService<T: Response> {
    var request: APIRequest?
    init(request: APIRequest) {
        self.request = request
    }

    func excute(target: UIViewController, success: @escaping (_ response: T?) -> Void, error: @escaping (_ error : String?) -> Void) {
        request?.printInfomationRequest()
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 120
        Alamofire.request(request!.fullUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!,
                            method: request!.method,
                            parameters: request?.parameters,
                            headers: request?.header).validate().responseJSON() { response in
                                print(self.request!.fullUrl)
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                target.hideLoading()
                success(T.init(json: json))
                print(json)
            } else {
                target.hideLoading()
                error("\(response.result.error!)")
            }
        }
    }
}

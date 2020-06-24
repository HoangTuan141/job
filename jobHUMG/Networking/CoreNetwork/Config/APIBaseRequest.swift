//
//  APIRequest.swift
//  iOS Structure MVC
//
//  Created by Vinh Dang on 12/7/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public enum APIParameterType {
    case body(_ parameters: Parameters)
    case raw(_ text: String)
    case multipart(data: Data?, parameters: Parameters, name: String, fileName: String, mimeType: String)
    case binary(_ data: Data)
}

//
//  ListPostFindJobAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/22/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseListPostFindJob: Response {
    var data = [DataListPostFindJob]()
    
    init(json: JSON) {
        if let listData = json["data"].array {
            for data in listData {
                self.data.append(DataListPostFindJob(json: data))
            }
        }
    }
}

struct DataListPostFindJob: Response {
    var id: Int
    var career: String
    var location: String
    var description: String
    var startDateTime: Int
    var endDateTime: Int
    var likeCount: Int
    var commentCount: Int
    var userName: String
    var userAvatar: String
    var createdAt: Int
    var isLike: Bool
    var userId: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.career = json["career"].stringValue
        self.location = json["location"].stringValue
        self.description = json["description"].stringValue
        self.startDateTime = json["startDatetime"].intValue
        self.endDateTime = json["endDatetime"].intValue
        self.likeCount = json["like_count"].intValue
        self.commentCount = json["comment_count"].intValue
        self.userName = json["user_name"].stringValue
        self.userAvatar = json["user_avatar"].stringValue
        self.createdAt = json["created_at"].intValue
        self.isLike = json["is_liked"].boolValue
        self.userId = json["user_id"].intValue
    }
}

class ListPostFindJobAPI: APIService<ResponseListPostFindJob> {
    init() {
        super.init(request: APIRequest(name: "Get list post find job",
                                       path: "api/post/member",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

class SearchPostFindJobAPI: APIService<ResponseListPostFindJob> {
    init(location: String?, career: String?, description: String?) {
        super.init(request: APIRequest(name: "Search Post Find Job API",
                                       path: "api/post/member/search/params?company_name=&location=\(location ?? "")&wage=&career=\(career ?? "")&description=\(description ?? "")",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

//
//  RecruitmentPostAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/19/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseDetailRecuitmentPost: Response {
    var data: DataDetailRecruitmentPost?
    
    init(json: JSON) {
        self.data = DataDetailRecruitmentPost(json: json["data"])
    }
}

struct DataDetailRecruitmentPost: Response {
    var id: Int
    var career: String
    var companyName: String
    var wage: String
    var location: String
    var description: String
    var startDateTime: Int
    var endDateTime: Int
    var likeCount: Int
    var commentCount: Int
    var userName: String
    var userAvatar: String
    var createdAt: Int
    var comment = [CommentDetailRecruitmentPost]()
    var isLike: Bool
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.career = json["career"].stringValue
        self.companyName = json["company_name"].stringValue
        self.wage = json["wage"].stringValue
        self.location = json["location"].stringValue
        self.description = json["description"].stringValue
        self.startDateTime = json["startDatetime"].intValue
        self.endDateTime = json["endDatetime"].intValue
        self.likeCount = json["like_count"].intValue
        self.commentCount = json["comment_count"].intValue
        self.userName = json["user_name"].stringValue
        self.userAvatar = json["user_avatar"].stringValue
        self.createdAt = json["created_at"].intValue
        if let comments = json["comment"].array {
            for comment in comments {
                self.comment.append(CommentDetailRecruitmentPost(json: comment))
            }
        }
        self.isLike = json["is_liked"].boolValue
    }
}

struct CommentDetailRecruitmentPost: Response {
    var id: Int
    var content: String
    var userName: String
    var userAvatar: String
    var createdAt: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.content = json["content"].stringValue
        self.userName = json["user_name"].stringValue
        self.userAvatar = json["user_avatar"].stringValue
        self.createdAt = json["created_at"].intValue
    }
}

class DetailRecruitmentPostAPI: APIService<ResponseDetailRecuitmentPost> {
    init(id: Int) {
        super.init(request: APIRequest(name: "Get list recruitment post",
                                       path: "api/post/employer/\(id)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

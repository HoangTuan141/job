//
//  DetailReviewCompanyAPI.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/25/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseDetailReviewCompany: Response {
    var data: DataDetailReviewCompany?
    
    init(json: JSON) {
        self.data = DataDetailReviewCompany(json: json["data"])
    }
}

struct DataDetailReviewCompany: Response {
    var id: Int
    var name: String
    var address: String
    var career: String
    var createdAt: Int
    var updatedAt: Int
    var avatar: String
    var ratingStar: Int
    var ratingCount: Int
    var ratingList = [CommentReview]()
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.address = json["address"].stringValue
        self.career = json["career"].stringValue
        self.createdAt = json["created_at"].intValue
        self.updatedAt = json["updated_at"].intValue
        self.avatar = json["avatar"].stringValue
        self.ratingStar = json["rating_star"].intValue
        self.ratingCount = json["rating_count"].intValue
        
        if let listReview = json["rating_list"].array {
            for review in listReview {
                self.ratingList.append(CommentReview(json: review))
            }
        }
    }
}

struct CommentReview: Response {
    var id: Int
    var reviewName: String
    var reviewContent: String
    var star: Int
    var userAvatar: String
    var likeCount: Int
    var disLikeCount: Int
    var createdAt: Int
    var updatedAt: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.reviewName = json["review_name"].stringValue
        self.reviewContent = json["review_content"].stringValue
        self.star = json["star"].intValue
        self.userAvatar = json["user_avatar"].stringValue
        self.likeCount = json["like_count"].intValue
        self.disLikeCount = json["dislike_count"].intValue
        self.createdAt = json["created_at"].intValue
        self.updatedAt = json["updated_at"].intValue
    }
}

class DetailReviewCompanyAPI: APIService<ResponseDetailReviewCompany> {
    init(id: Int) {
        super.init(request: APIRequest(name: "Get Detail Review Company API",
                                       path: "api/review/company/\(id)",
                                       method: .get,
                                       header: APIRequest.bearerHeader,
                                       parameters: nil))
    }
}

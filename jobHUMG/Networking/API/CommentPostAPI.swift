//
//  CommentPostAPI.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 6/23/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ResponseCommentPost: Response {
    var error: String
    var message: String
    
    init(json: JSON) {
        self.error = json["errors"].stringValue
        self.message = json["message"].stringValue
    }
}

class CommentPostAPI: APIService<ResponseCommentPost> {
    init(content: String, postId: Int, type: String) {
        let params = ["content": content,
                      "post_id": postId,
                      "type": type] as [String: Any]
        super.init(request: APIRequest(name: "Comment post API",
                                       path: "api/post/comment",
                                       method: .post,
                                       header: APIRequest.bearerHeader,
                                       parameters: params))
    }
}

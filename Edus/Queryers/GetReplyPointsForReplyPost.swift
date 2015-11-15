//
//  GetReplyPointsForReplyPost.swift
//  Edus
//
//  Created by michael ninh on 11/14/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class GetPointsForReplyPost{
    
    static func getPointsForReplyPost(completionBlock: PFQueryArrayResultBlock, replyPost:ReplyPost) {
        let query = PFQuery(className: "ReplyPostPoints")
        query.whereKey("toPost", equalTo: replyPost)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
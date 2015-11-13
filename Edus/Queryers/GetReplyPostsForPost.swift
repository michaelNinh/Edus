//
//  GetReplyPostsForPost.swift
//  Edus
//
//  Created by michael ninh on 11/13/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetReplyPostsForPost{
    
    static func getReplyPostsForPost(completionBlock: PFQueryArrayResultBlock, post: Post, range: Range<Int>){
        
        let query = PFQuery(className: "ReplyPost")
        query.whereKey("toPost", equalTo: post)
        query.includeKey("toReplyPostPoints")
        query.orderByDescending("createdAt")
        
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}
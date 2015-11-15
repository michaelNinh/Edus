//
//  GetPostsForClass.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetPostsForClass{
    
    static func getPostsForClass(completionBlock: PFQueryArrayResultBlock, classroom: Classroom, range: Range<Int>){
        
        let query = PFQuery(className: "Post")
        //this is where I would modify to create different post category results
        query.whereKey("toClassroom", equalTo: classroom)
        query.includeKey("toPostPoints")
        query.orderByDescending("createdAt")
        
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}
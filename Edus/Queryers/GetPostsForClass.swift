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
        
        let sameClassQuery = PFQuery(className: "Post")
        //this is where I would modify to create different post category results
        sameClassQuery.whereKey("toClassroom", equalTo: classroom)
        //sameClassQuery.includeKey("toPostPoints")
        //sameClassQuery.orderByDescending("createdAt")
        
        let sameSubjectQuery = PFQuery(className: "Post")
        sameSubjectQuery.whereKey("subject", equalTo: classroom.subject!)
        //sameSubjectQuery.includeKey("toPostPoints")
        //sameSubjectQuery.orderByDescending("createdAt")
        
        let postQuery = PFQuery.orQueryWithSubqueries([sameClassQuery, sameSubjectQuery])
        postQuery.includeKey("toPostPoints")
        postQuery.orderByDescending("createdAt")
        postQuery.skip = range.startIndex
        postQuery.limit = range.endIndex - range.startIndex
        postQuery.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}
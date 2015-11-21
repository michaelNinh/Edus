//
//  GetUserEnrolledClasses.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetUserEnrolledClasses {
    
    
    static func getUserEnrolledClasses(completionBlock: PFQueryArrayResultBlock, range: Range<Int>){
        
        let enrolledQuery = PFQuery(className: "_User")
        enrolledQuery.includeKey("enrolledClasses")
        enrolledQuery.skip = range.startIndex
        enrolledQuery.limit = range.endIndex - range.startIndex
        
        enrolledQuery.getObjectInBackgroundWithId(PFUser.currentUser()!.objectId!)
            

        
}

}








//
//  AvailableSchoolListQuery.swift
//  Edus
//
//  Created by michael ninh on 11/10/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse

class GetAvailableSchools{
    
    //MUST MAKE SURE VIEW GETS UPDATED
    
    static func getClassesForUser(completionBlock: PFQueryArrayResultBlock){
        let query = PFQuery(className: "School")
        query.orderByAscending("schoolName")
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
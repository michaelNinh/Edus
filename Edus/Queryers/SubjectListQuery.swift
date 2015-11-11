//
//  SubjectListQuery.swift
//  Edus
//
//  Created by michael ninh on 11/11/15.
//  Copyright © 2015 Cognitus. All rights reserved.
//

import Foundation
import Parse


class GetSubjectList{
    
    //MUST MAKE SURE VIEW GETS UPDATED
    
    static func getSubjectList(completionBlock: PFQueryArrayResultBlock){
        let query = PFQuery(className: "SubjectList")
        query.orderByAscending("subjectName")
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
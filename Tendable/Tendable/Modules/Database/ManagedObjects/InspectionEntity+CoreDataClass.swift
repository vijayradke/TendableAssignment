//
//  InspectionEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(InspectionEntity)
public class InspectionEntity: NSManagedObject {
    
    func prepareEntity(modelId: Int, emailId: String) {
        id = Int16(modelId)
        email = emailId
    }

}

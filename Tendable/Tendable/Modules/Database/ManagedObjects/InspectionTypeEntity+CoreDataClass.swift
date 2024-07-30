//
//  InspectionTypeEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(InspectionTypeEntity)
public class InspectionTypeEntity: NSManagedObject {
    
    func prepareEntity(inspectionTypeModel: InspectionTypeModel) {
        id = Int16(inspectionTypeModel.id)
        name = inspectionTypeModel.name
        access = inspectionTypeModel.access
    }

}

//
//  InspectionTypeEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake on 30/07/24.
//
//

import Foundation
import CoreData


extension InspectionTypeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionTypeEntity> {
        return NSFetchRequest<InspectionTypeEntity>(entityName: "InspectionTypeEntity")
    }

    @NSManaged public var access: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var relationshipInspection: InspectionEntity?

}

extension InspectionTypeEntity : Identifiable {

}

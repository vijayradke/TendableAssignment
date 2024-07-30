//
//  AreaEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake on 30/07/24.
//
//

import Foundation
import CoreData


extension AreaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AreaEntity> {
        return NSFetchRequest<AreaEntity>(entityName: "AreaEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var relationshipInspection: InspectionEntity?

}

extension AreaEntity : Identifiable {

}

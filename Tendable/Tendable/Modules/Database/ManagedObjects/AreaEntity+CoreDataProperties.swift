//
//  AreaEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake.
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

}

extension AreaEntity : Identifiable {

}

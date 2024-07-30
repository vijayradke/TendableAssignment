//
//  InspectionEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake on 30/07/24.
//
//

import Foundation
import CoreData


extension InspectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionEntity> {
        return NSFetchRequest<InspectionEntity>(entityName: "InspectionEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int16
    @NSManaged public var submitStatus: Bool
    @NSManaged public var area: AreaEntity?
    @NSManaged public var inspectionType: InspectionTypeEntity?
    @NSManaged public var survey: SurveyEntity?

}

extension InspectionEntity : Identifiable {

}

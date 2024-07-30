//
//  AnswerChoiceEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData


extension AnswerChoiceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerChoiceEntity> {
        return NSFetchRequest<AnswerChoiceEntity>(entityName: "AnswerChoiceEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var score: Double

}

extension AnswerChoiceEntity : Identifiable {

}

//
//  SurveyEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake on 30/07/24.
//
//

import Foundation
import CoreData


extension SurveyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SurveyEntity> {
        return NSFetchRequest<SurveyEntity>(entityName: "SurveyEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var categories: NSOrderedSet?
    @NSManaged public var relationshipInspection: InspectionEntity?

}

// MARK: Generated accessors for categories
extension SurveyEntity {

    @objc(insertObject:inCategoriesAtIndex:)
    @NSManaged public func insertIntoCategories(_ value: CategoryEntity, at idx: Int)

    @objc(removeObjectFromCategoriesAtIndex:)
    @NSManaged public func removeFromCategories(at idx: Int)

    @objc(insertCategories:atIndexes:)
    @NSManaged public func insertIntoCategories(_ values: [CategoryEntity], at indexes: NSIndexSet)

    @objc(removeCategoriesAtIndexes:)
    @NSManaged public func removeFromCategories(at indexes: NSIndexSet)

    @objc(replaceObjectInCategoriesAtIndex:withObject:)
    @NSManaged public func replaceCategories(at idx: Int, with value: CategoryEntity)

    @objc(replaceCategoriesAtIndexes:withCategories:)
    @NSManaged public func replaceCategories(at indexes: NSIndexSet, with values: [CategoryEntity])

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CategoryEntity)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CategoryEntity)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSOrderedSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSOrderedSet)

}

extension SurveyEntity : Identifiable {

}

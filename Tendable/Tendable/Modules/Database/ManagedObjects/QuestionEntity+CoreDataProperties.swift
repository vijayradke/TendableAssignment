//
//  QuestionEntity+CoreDataProperties.swift
//  Tendable
//
//  Created by Vijay Radake on 30/07/24.
//
//

import Foundation
import CoreData


extension QuestionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var selectedAnswerChoiceId: Int16
    @NSManaged public var answerChoices: NSOrderedSet?
    @NSManaged public var relationshipCategory: CategoryEntity?

}

// MARK: Generated accessors for answerChoices
extension QuestionEntity {

    @objc(insertObject:inAnswerChoicesAtIndex:)
    @NSManaged public func insertIntoAnswerChoices(_ value: AnswerChoiceEntity, at idx: Int)

    @objc(removeObjectFromAnswerChoicesAtIndex:)
    @NSManaged public func removeFromAnswerChoices(at idx: Int)

    @objc(insertAnswerChoices:atIndexes:)
    @NSManaged public func insertIntoAnswerChoices(_ values: [AnswerChoiceEntity], at indexes: NSIndexSet)

    @objc(removeAnswerChoicesAtIndexes:)
    @NSManaged public func removeFromAnswerChoices(at indexes: NSIndexSet)

    @objc(replaceObjectInAnswerChoicesAtIndex:withObject:)
    @NSManaged public func replaceAnswerChoices(at idx: Int, with value: AnswerChoiceEntity)

    @objc(replaceAnswerChoicesAtIndexes:withAnswerChoices:)
    @NSManaged public func replaceAnswerChoices(at indexes: NSIndexSet, with values: [AnswerChoiceEntity])

    @objc(addAnswerChoicesObject:)
    @NSManaged public func addToAnswerChoices(_ value: AnswerChoiceEntity)

    @objc(removeAnswerChoicesObject:)
    @NSManaged public func removeFromAnswerChoices(_ value: AnswerChoiceEntity)

    @objc(addAnswerChoices:)
    @NSManaged public func addToAnswerChoices(_ values: NSOrderedSet)

    @objc(removeAnswerChoices:)
    @NSManaged public func removeFromAnswerChoices(_ values: NSOrderedSet)

}

extension QuestionEntity : Identifiable {

}

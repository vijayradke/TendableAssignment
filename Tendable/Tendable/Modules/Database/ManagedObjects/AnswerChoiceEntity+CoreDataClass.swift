//
//  AnswerChoiceEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(AnswerChoiceEntity)
public class AnswerChoiceEntity: NSManagedObject {

    func prepareEntity(answerChoiceModel: AnswerChoiceModel) {
        id = Int16(answerChoiceModel.id)
        name = answerChoiceModel.name
        score = answerChoiceModel.score
    }
}

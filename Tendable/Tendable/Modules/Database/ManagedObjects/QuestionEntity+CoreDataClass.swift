//
//  QuestionEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(QuestionEntity)
public class QuestionEntity: NSManagedObject {

    func prepareEntity(questionModel: QuestionModel) {
        id = Int16(questionModel.id)
        name = questionModel.name
    }
}

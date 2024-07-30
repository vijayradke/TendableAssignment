//
//  InspectionViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

class InspectionDataModel: Identifiable {
    let id: Int
    let areaId: Int
    let areaName: String
    let inspectionTypeId: Int
    let inspectionName: String
    let inspectionAccess: String
    let surveyId: Int
    let surveyCategories: [SurveyCategoryViewModel]
    var submitStatus: Bool = false
   
    var totalScore: Double {
        let allQuestions = surveyCategories.flatMap {$0.questions}
        let allScores = allQuestions.map {$0.userScore}
        let total = allScores.reduce(0.0, +)
        return total
    }
    
    init(model: InspectionModel) {
        id = model.id
        areaId = model.area.id
        areaName = model.area.name
        inspectionTypeId = model.inspectionType.id
        inspectionName = model.inspectionType.name
        inspectionAccess = model.inspectionType.access
        surveyId = model.survey.id
        surveyCategories = model.survey.categories.map {SurveyCategoryViewModel(model: $0)}
    }
    
    init(entity: InspectionEntity) {
        id = Int(entity.id)
        areaId = Int(entity.area?.id ?? 0)
        areaName = entity.area?.name ?? ""
        inspectionTypeId = Int(entity.inspectionType?.id ?? 0)
        inspectionName = entity.inspectionType?.name ?? ""
        inspectionAccess = entity.inspectionType?.access ?? ""
        surveyId = Int(entity.survey?.id ?? 0)
        submitStatus = entity.submitStatus
        
        if let categories = entity.survey?.categories?.array as? [CategoryEntity] {
            surveyCategories = categories.map {SurveyCategoryViewModel(entity: $0)}
        } else {
            surveyCategories = []
        }
    }
}

class SurveyCategoryViewModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let questions: [QuestionViewModel]
    
    init(model: CategoryModel) {
        id = model.id
        name = model.name
        questions = model.questions.map {QuestionViewModel(model: $0)}
    }
    
    init(entity: CategoryEntity) {
        id = Int(entity.id)
        name = entity.name ?? ""
        if let questionEntities = entity.questions?.array as? [QuestionEntity] {
            questions = questionEntities.map {QuestionViewModel(entity: $0)}
        } else {
            questions = []
        }
    }
    
    static func == (lhs: SurveyCategoryViewModel, rhs: SurveyCategoryViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

class QuestionViewModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoiceViewModel]
    var selectedAnswerChoiceId: Int?
    
    var userScore: Double {
        guard let selectedAnswer = answerChoices.filter({ $0.id == selectedAnswerChoiceId}).first else {
            return 0.0
        }
        return selectedAnswer.score
    }
    
    init(model: QuestionModel) {
        id = model.id
        name = model.name
        selectedAnswerChoiceId = model.selectedAnswerChoiceId
        answerChoices = model.answerChoices.map {AnswerChoiceViewModel(model: $0)}
    }
    
    init(entity: QuestionEntity) {
        id = Int(entity.id)
        name = entity.name ?? ""
        let choiceId = Int(entity.selectedAnswerChoiceId)
        selectedAnswerChoiceId = choiceId != 0 ? choiceId : nil
        if let answerChoiceEntities = entity.answerChoices?.array as? [AnswerChoiceEntity] {
            answerChoices = answerChoiceEntities.map {AnswerChoiceViewModel(entity: $0)}
        } else {
            answerChoices = []
        }
    }
    
    static func == (lhs: QuestionViewModel, rhs: QuestionViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

class AnswerChoiceViewModel: Identifiable {
    let id: Int
    let name: String
    let score: Double
    
    init(model: AnswerChoiceModel) {
        id = model.id
        name = model.name
        score = model.score
    }
    
    init(entity: AnswerChoiceEntity) {
        id = Int(entity.id)
        name = entity.name ?? ""
        score = entity.score
    }
}

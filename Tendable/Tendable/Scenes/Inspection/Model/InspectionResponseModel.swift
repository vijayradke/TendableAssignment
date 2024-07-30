//
//  InspectionResponseModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

// MARK: - Inspection Data
struct InspectionResponseModel: Codable {
    let inspection: InspectionModel
}

// MARK: - Inspection
struct InspectionModel: Codable {
    let id: Int
    let area: AreaModel
    let inspectionType: InspectionTypeModel
    let survey: SurveyModel
}

// MARK: - Area
struct AreaModel: Codable {
    let id: Int
    let name: String
}

// MARK: - InspectionType
struct InspectionTypeModel: Codable {
    let id: Int
    let name: String
    let access: String
}

// MARK: - Survey
struct SurveyModel: Codable {
    let id: Int
    let categories: [CategoryModel]
}

// MARK: - Category
struct CategoryModel: Codable {
    let id: Int
    let name: String
    let questions: [QuestionModel]
}

// MARK: - Question
struct QuestionModel: Codable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoiceModel]
    let selectedAnswerChoiceId: Int?
}

// MARK: - AnswerChoice
struct AnswerChoiceModel: Codable {
    let id: Int
    let name: String
    let score: Double
}

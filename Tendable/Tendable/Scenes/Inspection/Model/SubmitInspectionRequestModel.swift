//
//  SubmitInspectionRequestModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

struct SubmitInspectionRequestModel: Codable {
    let inspection: InspectionModel
    
    init(viewModel: InspectionDataModel) {
        let area = AreaModel(id: viewModel.areaId, name: viewModel.areaName)
        let inspectionType = InspectionTypeModel(id: viewModel.inspectionTypeId, name: viewModel.inspectionName, access: viewModel.inspectionAccess)
        let categories = viewModel.surveyCategories.map {CategoryModel(viewModel: $0)}
        let survey = SurveyModel(id: viewModel.surveyId, categories: categories)
        inspection = InspectionModel(id: viewModel.id, area: area, inspectionType: inspectionType, survey: survey)
    }
}


extension CategoryModel {
    init(viewModel: SurveyCategoryViewModel) {
        id = viewModel.id
        name = viewModel.name
        questions = viewModel.questions.map {QuestionModel(viewModel: $0)}
    }
}

extension QuestionModel {
    init(viewModel: QuestionViewModel) {
        id = viewModel.id
        name = viewModel.name
        answerChoices = viewModel.answerChoices.map { AnswerChoiceModel(viewModel: $0) }
        selectedAnswerChoiceId = viewModel.selectedAnswerChoiceId
    }
}

extension AnswerChoiceModel {
    init(viewModel: AnswerChoiceViewModel) {
        id = viewModel.id
        name = viewModel.name
        score = viewModel.score
    }
}

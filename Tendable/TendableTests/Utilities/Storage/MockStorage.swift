//
//  MockStorage.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation
@testable import Tendable

class MockStorage: Storage {
    
    var temporaryStorage: [InspectionDataModel] = []
    
    func storeInspection(model: InspectionResponseModel) {
        let dataModel = InspectionDataModel(model: model.inspection)
        temporaryStorage.append(dataModel)
    }
    
    func fetchAllStoredInspection() -> [InspectionDataModel]? {
        return temporaryStorage
    }
    
    func updateAnswerChoiceForInspection(id: Int, categoryId: Int, questionId: Int, answerChoiceId: Int) {
        guard let index = temporaryStorage.firstIndex(where: { $0.id == id }) else { return }
        let inspection = temporaryStorage[index]
        guard let category = inspection.surveyCategories.filter ({$0.id == categoryId}).first else { return }
        guard let question = category.questions.filter ({$0.id == questionId}).first else { return }
        question.selectedAnswerChoiceId = answerChoiceId
    }
    
    func updateSubmitStatusFor(inspectionId: Int, status: Bool) {
        guard let index = temporaryStorage.firstIndex(where: { $0.id == inspectionId }) else { return }
        let inspection = temporaryStorage[index]
        inspection.submitStatus = status
    }
    
    func deleteInspection(inspectionId: Int) {
        temporaryStorage.removeAll(where: { $0.id == inspectionId })
    }
        
}

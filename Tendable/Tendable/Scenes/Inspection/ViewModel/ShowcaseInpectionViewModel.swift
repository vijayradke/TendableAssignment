//
//  ShowcaseInpectionViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

class ShowcaseInpectionViewModel: ObservableObject {
    
    @Published var inspectionViewModel: InspectionDataModel?
    @Published var isLoading: Bool = false
    @Published var currentCategory: SurveyCategoryViewModel?
    @Published var currentQuestion: QuestionViewModel?
    @Published var errorMessage: String?
    @Published var inspectionSubmitted: Bool = false
    @Published var retryInspection: Bool = false
    private var inspectionScore: Double = 0.0
    
    let networkManager: NetworkManagerProtocol
    let storage: Storage
        
    var formattedInpectionScore: String {
        return String(format: "%.2f", inspectionScore)
    }
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(), storage: Storage = PersistenceController.shared) {
        self.networkManager = networkManager
        self.storage = storage
    }

    private func inspectionReceived(model: InspectionResponseModel) {
        inspectionViewModel = InspectionDataModel(model: model.inspection)
        currentCategory = inspectionViewModel?.surveyCategories.first
        currentQuestion = currentCategory?.questions.first
    }
    
    func updateAnswerChoice(id: Int) {
        currentQuestion?.selectedAnswerChoiceId = id
        errorMessage = nil
        self.objectWillChange.send()
        
        if isLastQuestion() {
            guard let inspectionViewModel, let currentCategory, let currentQuestion else { return }
            storage.updateAnswerChoiceForInspection(id: inspectionViewModel.id,
                                                    categoryId: currentCategory.id,
                                                    questionId: currentQuestion.id,
                                                    answerChoiceId: id)
        }
    }
    
    func isLastQuestion() -> Bool {
        guard let inspectionViewModel, let currentCategory, let currentQuestion else { return false }
        let questionIndex = currentCategory.questions.firstIndex(where: {$0.id == currentQuestion.id})
        let categoryIndex = inspectionViewModel.surveyCategories.firstIndex(where: {$0.id == currentCategory.id})
        return questionIndex == currentCategory.questions.count - 1 && categoryIndex == inspectionViewModel.surveyCategories.count - 1
    }
    
    func displayInspectionModel(_ model: InspectionDataModel) {
        inspectionViewModel = model
        currentCategory = inspectionViewModel?.surveyCategories.first
        currentQuestion = currentCategory?.questions.first
    }

}

// MARK: - API Calls
extension ShowcaseInpectionViewModel {
   
    func fetchInspections() {
        isLoading = true
        let service = InspectionService.startInspection
        Task {
            let result = await networkManager.performRequest(service: service, resposeType: InspectionResponseModel.self)
            await MainActor.run {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.inspectionReceived(model: model)
                    self.storage.storeInspection(model: model)
                case .failure(let error):
                    self.retryInspection = true
                }
            }
        }
    }
    
    func submitInspection(request: SubmitInspectionRequestModel) {
        isLoading = true
        let service = InspectionService.submitInspection(requestModel: request)
        Task {
            let result = await networkManager.performRequest(service: service, resposeType: EmptyResponseModel.self)
            await MainActor.run {
                self.isLoading = false
                switch result {
                case .success:
                    self.inspectionSubmitted = true
                    self.storage.updateSubmitStatusFor(inspectionId: request.inspection.id, status: true)
                case .failure(let error):
                    self.errorMessage = "Failed to submit inspection. Please try again."
                    print("Failed with error: \(error)")
                }
            }
        }
    }
}

extension ShowcaseInpectionViewModel {
    func nextButtonAction() {
        guard let inspectionViewModel, let currentCategory, let currentQuestion else { return }
        
        guard let answerChoiceId = currentQuestion.selectedAnswerChoiceId else {
            errorMessage = "Please answer the question."
            return
        }
        storage.updateAnswerChoiceForInspection(id: inspectionViewModel.id,
                                                categoryId: currentCategory.id,
                                                questionId: currentQuestion.id,
                                                answerChoiceId: answerChoiceId)
        
        let allCategories = inspectionViewModel.surveyCategories
        if let index = currentCategory.questions.firstIndex(where: {$0.id == currentQuestion.id}), index < currentCategory.questions.count - 1 {
            self.currentQuestion = currentCategory.questions[index + 1]
            return
        }
        if let index = allCategories.firstIndex(where: {$0.id == currentCategory.id}), index < allCategories.count - 1 {
            self.currentCategory = allCategories[index + 1]
            self.currentQuestion = self.currentCategory?.questions.first
        }
    }
    
    func previousButtonAction() {
        guard let inspectionViewModel, let currentCategory, let currentQuestion else { return }
        let allCategories = inspectionViewModel.surveyCategories
        if let index = currentCategory.questions.firstIndex(where: {$0.id == currentQuestion.id}), index > 0 {
            self.currentQuestion = currentCategory.questions[index - 1]
            return
        }
        if let index = allCategories.firstIndex(where: {$0.id == currentCategory.id}), index > 0 {
            self.currentCategory = allCategories[index - 1]
            self.currentQuestion = self.currentCategory?.questions.last
        }
    }
    
    func submitButtonAction() {
        guard let inspectionViewModel, let currentCategory, let currentQuestion else { return }
        guard let answerChoiceId = currentQuestion.selectedAnswerChoiceId else {
            errorMessage = "Please answer the question."
            return
        }
        storage.updateAnswerChoiceForInspection(id: inspectionViewModel.id,
                                                categoryId: currentCategory.id,
                                                questionId: currentQuestion.id,
                                                answerChoiceId: answerChoiceId)
        inspectionScore = inspectionViewModel.totalScore
        let requestModel = SubmitInspectionRequestModel(viewModel: inspectionViewModel)
        submitInspection(request: requestModel)
    }
}


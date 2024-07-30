//
//  ShowcaseInpectionViewModelTests.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import XCTest
@testable import Tendable

final class ShowcaseInpectionViewModelTests: XCTestCase {
    var viewModel: ShowcaseInpectionViewModel!
    
    override func setUpWithError() throws {
        viewModel = ShowcaseInpectionViewModel(networkManager: MockNetworkManager(), storage: MockStorage())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchInspections() {
        let expectation = XCTestExpectation(description: "Wait for 2 seconds")
        viewModel.fetchInspections()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(viewModel.inspectionViewModel)
        XCTAssertNotNil(viewModel.currentCategory)
        XCTAssertNotNil(viewModel.currentQuestion)
    }
    
    func testSubmitInspection() {
        let inspectionResponseModel = DataStore.inspectionResponseModel()
        XCTAssertNotNil(inspectionResponseModel)
        let inspectionDataModel = InspectionDataModel(model: inspectionResponseModel!.inspection)
        let submitRequest = SubmitInspectionRequestModel(viewModel: inspectionDataModel)
        viewModel.submitInspection(request: submitRequest)
        
        let expectation = XCTestExpectation(description: "Wait for 2 seconds")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(viewModel.inspectionSubmitted)
    }
    
    private func setInspectionData(updateAnswer: Bool) {
        let inspectionResponseModel = DataStore.inspectionResponseModel()
        XCTAssertNotNil(inspectionResponseModel)
        let inspectionDataModel = InspectionDataModel(model: inspectionResponseModel!.inspection)
        viewModel.displayInspectionModel(inspectionDataModel)
        if updateAnswer {
            viewModel.updateAnswerChoice(id: 1)
        }
    }
    
    func testNextButtonActionFailure() {
        setInspectionData(updateAnswer: false)
        let currentQuestionId = viewModel.currentQuestion?.id
        viewModel.nextButtonAction()
        XCTAssertEqual(viewModel.currentQuestion?.id, currentQuestionId)
    }
    
    func testNextButtonActionSuccess() {
        setInspectionData(updateAnswer: true)
        let currentQuestionId = viewModel.currentQuestion?.id
        viewModel.nextButtonAction()
        XCTAssertNotEqual(viewModel.currentQuestion?.id, currentQuestionId)
    }
    
    func testPreviousButtonActionFailure() {
        setInspectionData(updateAnswer: false)
        let curentQuestionId = viewModel.currentQuestion?.id
        viewModel.previousButtonAction()
        XCTAssertEqual(viewModel.currentQuestion?.id, curentQuestionId)
    }
    
    func testPreviousButtonActionSuccess() {
        setInspectionData(updateAnswer: true)
        viewModel.nextButtonAction()
        let nextQuestionId = viewModel.currentQuestion?.id
        viewModel.previousButtonAction()
        XCTAssertNotEqual(viewModel.currentQuestion?.id, nextQuestionId)
    }
    
    func testSubmitButtonActionFailure() {
        setInspectionData(updateAnswer: false)
        viewModel.submitButtonAction()
        XCTAssertNil(viewModel.currentQuestion?.selectedAnswerChoiceId)
    }
    
    func testSubmitButtonActionSuccess() {
        setInspectionData(updateAnswer: true)
        viewModel.submitButtonAction()
        let inspectionScore = Double(viewModel.formattedInpectionScore)
        XCTAssertGreaterThan(inspectionScore!, 0.0)
    }
}

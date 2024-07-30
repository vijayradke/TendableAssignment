//
//  StoredInspectionListViewModelTests.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import XCTest
@testable import Tendable

final class StoredInspectionListViewModelTests: XCTestCase {

    var viewModel: StoredInspectionListViewModel!
    
    override func setUpWithError() throws {
        viewModel = StoredInspectionListViewModel(storage: MockStorage())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchStoredInspectionsForEmptyInspection() {
        viewModel.fetchStoredInspections()
        XCTAssertEqual(viewModel.storedInspections.count, 0)
    }
    
    func testFetchStoredInspectionsForValidInspection() {
        let inspectionModel = DataStore.inspectionResponseModel()
        XCTAssertNotNil(inspectionModel)
        viewModel.storage.storeInspection(model: inspectionModel!)
        viewModel.fetchStoredInspections()
        XCTAssertEqual(viewModel.storedInspections.count, 1)
    }
    
    func testDeleteInspection() {
        let inspectionModel = DataStore.inspectionResponseModel()
        XCTAssertNotNil(inspectionModel)
        viewModel.storage.storeInspection(model: inspectionModel!)
        viewModel.fetchStoredInspections()
        XCTAssertEqual(viewModel.storedInspections.count, 1)
        let inspectionToDelete = viewModel.storedInspections[0]
        viewModel.delete(inspection: inspectionToDelete)
        viewModel.fetchStoredInspections()
        XCTAssertEqual(viewModel.storedInspections.count, 0)
    }
    
}

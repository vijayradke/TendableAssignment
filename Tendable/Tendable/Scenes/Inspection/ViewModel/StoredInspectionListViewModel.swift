//
//  StoredInspectionListViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

class StoredInspectionListViewModel: ObservableObject {
    @Published var storedInspections: [InspectionDataModel] = []
    
    let storage: Storage
    
    init(storage: Storage = PersistenceController.shared) {
        self.storage = storage
    }
    
    func fetchStoredInspections() {
        if let data = storage.fetchAllStoredInspection() {
            storedInspections = data
        }
    }
    
    func delete(inspection: InspectionDataModel) {
        storage.deleteInspection(inspectionId: inspection.id)
    }
}

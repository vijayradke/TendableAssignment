//
//  StoredInspectionListView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct StoredInspectionListView: View {
    @StateObject private var viewModel = StoredInspectionListViewModel()
    
    var body: some View {
        VStack {
            if viewModel.storedInspections.isEmpty {
                Text("No inspection stored. Please start new inspection.")
                    .font(.title2)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.storedInspections) {inspection in
                        NavigationLink {
                            ShowcaseInpectionView(inspectionDataModel: inspection)
                        } label: {
                            StoredInspectionRowView(inspectionModel: inspection)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Stored Inspections")
        .onAppear {
            viewModel.fetchStoredInspections()
        }
    }
    
    func delete(at offsets: IndexSet) {
        if let index = offsets.first {
            viewModel.delete(inspection: viewModel.storedInspections[index])
        }
    }
}

#Preview {
    StoredInspectionListView()
}

struct StoredInspectionRowView: View {
    let inspectionModel: InspectionDataModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            let status = submissionStatus()
            Text(status.title)
                .font(.footnote)
                .foregroundStyle(status.textColor)
        }
    }
    
    var title: String {
        "Inspection: \(inspectionModel.id)"
    }
    
    func submissionStatus() -> (title: String, textColor: Color) {
        let title = inspectionModel.submitStatus ? "Submitted" : "Not Submitted"
        let textColor = inspectionModel.submitStatus ? Color.green : Color.gray
        return (title, textColor)
    }
}

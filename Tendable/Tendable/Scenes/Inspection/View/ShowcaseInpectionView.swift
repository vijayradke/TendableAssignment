//
//  ShowcaseInpectionView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct ShowcaseInpectionView: View {
    @StateObject var viewModel = ShowcaseInpectionViewModel()
    var inspectionDataModel: InspectionDataModel?
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.inspectionSubmitted {
                    submissionCompletedView
                } else if viewModel.inspectionViewModel != nil {
                    inspectionMainView
                } else if viewModel.retryInspection {
                    retryView
                }
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            .navigationTitle("Tendable")
            .navigationBarTitleDisplayMode(.inline)
            .disabled(viewModel.isLoading)
        }
        .onAppear() {
            if let inspectionDataModel {
                viewModel.displayInspectionModel(inspectionDataModel)
            } else {
                viewModel.fetchInspections()
            }
        }
    }
    
    var inspectionMainView: some View {
        VStack(alignment: .leading) {
            inspectionListView
            HStack {
                Spacer()
                AppPrimaryButton(title: "Previous", action: viewModel.previousButtonAction)
                Spacer()
                if viewModel.isLastQuestion() {
                    AppPrimaryButton(title: "Submit", action: viewModel.submitButtonAction, backgroundColor: .green)
                } else {
                    AppPrimaryButton(title: "Next", action: viewModel.nextButtonAction)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding()
    }
    
    var inspectionListView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                prepareTitleValueView(title: "Area:", subtitle: viewModel.inspectionViewModel?.areaName ?? "")
                prepareTitleValueView(title: "Inspection Type:", subtitle: viewModel.inspectionViewModel?.inspectionName ?? "")
                prepareTitleValueView(title: "Area:", subtitle: viewModel.currentCategory?.name ?? "")
                    .padding(.top, 20)
                questionAnswerView
                    .padding(.top, 20)
            }
        }
    }
    
    var questionAnswerView: some View {
        VStack(alignment: .leading) {
            Text("Question:")
                .fontWeight(.semibold)
            Text(viewModel.currentQuestion?.name ?? "")
            
            ForEach(viewModel.currentQuestion?.answerChoices ?? []) { answerModel in
                Button {
                    print("Selected = ", answerModel.name, answerModel.score)
                    viewModel.updateAnswerChoice(id: answerModel.id)
                } label: {
                    HStack {
                        let isSelected = viewModel.currentQuestion?.selectedAnswerChoiceId == answerModel.id
                        Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(isSelected ? Color.accentColor : .gray)
                            
                        Text(answerModel.name)
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
        }
    }
        
    @ViewBuilder
    func prepareTitleValueView(title: String, subtitle: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Text(subtitle)
            Spacer()
        }
    }
    
    var submissionCompletedView: some View {
        VStack(spacing: 10) {
            Text("Your inspection has been sumitted.")
            Text("Your Score is: \(viewModel.formattedInpectionScore)")
            Spacer()
        }
        .padding()
    }
    
    var retryView: some View {
        VStack {
            Text("Error in fetching inspection")
                .foregroundStyle(Color.red)
            AppPrimaryButton(title: "Retry", action: viewModel.fetchInspections, backgroundColor: .gray)
        }
    }
    

}

#Preview {
    ShowcaseInpectionView()
}

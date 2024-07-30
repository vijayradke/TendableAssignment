//
//  Persistence.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import CoreData


protocol Storage {
    func storeInspection(model: InspectionResponseModel)
    func fetchAllStoredInspection() -> [InspectionDataModel]?
    func updateAnswerChoiceForInspection(id: Int, categoryId: Int, questionId: Int, answerChoiceId: Int)
    func updateSubmitStatusFor(inspectionId: Int, status: Bool)
    func deleteInspection(inspectionId: Int)
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "Tendable")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController: Storage {
    
    func storeInspection(model: InspectionResponseModel) {
        let inspection = model.inspection
        /* We are deleting inspection if already present with same id.
         * In future based on requirement we can update existing inspection.
         * For simplicity we are deleting old one and creating new.
         */
        deleteInspection(inspectionId: inspection.id)
        
        let context = container.viewContext
        let inspectionEntity = InspectionEntity(context: context)
        inspectionEntity.prepareEntity(modelId: inspection.id, emailId: Preference.userEmail)
        
        let areaEntity = AreaEntity(context: context)
        areaEntity.prepareEntity(areaModel: inspection.area)
        inspectionEntity.area = areaEntity
        
        let inspectionTypeEntity = InspectionTypeEntity(context: context)
        inspectionTypeEntity.prepareEntity(inspectionTypeModel: inspection.inspectionType)
        inspectionEntity.inspectionType = inspectionTypeEntity
        
        // SurveyEntity Insertion
        let surveyEntity = SurveyEntity(context: context)
        surveyEntity.id = Int16(inspection.survey.id)
        
        // CategoryEntity Insertion
        for category in inspection.survey.categories {
            let categoryEntity = CategoryEntity(context: context)
            categoryEntity.prepareEntity(categoryModel: category)
            
            // QuestionEntity Insertion
            for question in category.questions {
                let questionEntity = QuestionEntity(context: context)
                questionEntity.prepareEntity(questionModel: question)
                
                // AnswerChoiceEntity Insertion
                for choice in question.answerChoices {
                    let answerChoiceEntity = AnswerChoiceEntity(context: context)
                    answerChoiceEntity.prepareEntity(answerChoiceModel: choice)
                    
                    questionEntity.addToAnswerChoices(answerChoiceEntity)
                }
                categoryEntity.addToQuestions(questionEntity)
            }
            surveyEntity.addToCategories(categoryEntity)
        }
        inspectionEntity.survey = surveyEntity
        
        do {
            try context.save()
        } catch {
            print("Error: Saving data")
        }
    }
    
    private func fetchInspectionEntityFor(id: Int) -> InspectionEntity? {
        let fetchRequest = NSFetchRequest<InspectionEntity>(entityName: "InspectionEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %d AND email = %@", id, Preference.userEmail)
        let context = container.viewContext
        do {
            let object = try context.fetch(fetchRequest)
            return object.first
        } catch {
            print("Error in fetching inpection")
        }
        return nil
    }
    
    func updateAnswerChoiceForInspection(id: Int, categoryId: Int, questionId: Int, answerChoiceId: Int) {
        guard let inspectionEntity = fetchInspectionEntityFor(id: id) else { return }
        guard let categories = inspectionEntity.survey?.categories?.array as? [CategoryEntity],
              let currentCategory = categories.filter({ $0.id == categoryId }).first else {
            return
        }
        guard let allQuestions = currentCategory.questions?.array as? [QuestionEntity],
              let currentQuestion = allQuestions.filter({ $0.id == questionId }).first else {
            return
        }
        currentQuestion.selectedAnswerChoiceId = Int16(answerChoiceId)
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error: Updating data")
        }
    }
    
    func fetchAllStoredInspection() -> [InspectionDataModel]? {
        let fetchRequest = NSFetchRequest<InspectionEntity>(entityName: "InspectionEntity")
        fetchRequest.predicate = NSPredicate(format: "email = %@", Preference.userEmail)
        let context = container.viewContext
        do {
            let object = try context.fetch(fetchRequest)
            return object.compactMap {InspectionDataModel(entity: $0)}
        } catch {
            print("Error in fetching inpection")
        }
        return nil
    }
    
    func updateSubmitStatusFor(inspectionId: Int, status: Bool) {
        guard let inspectionEntity = fetchInspectionEntityFor(id: inspectionId) else { return }
        inspectionEntity.submitStatus = status
        do {
            try container.viewContext.save()
        } catch {
            print("Error: Updating data")
        }
    }
    
    func deleteInspection(inspectionId: Int) {
        guard let inspectionEntity = fetchInspectionEntityFor(id: inspectionId) else { return }
        let context = container.viewContext
        context.delete(inspectionEntity)
        do {
            try container.viewContext.save()
        } catch {
            print("Error: Updating data")
        }
    }
}

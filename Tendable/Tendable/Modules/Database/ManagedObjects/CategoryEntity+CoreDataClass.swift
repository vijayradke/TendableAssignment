//
//  CategoryEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {
   
    func prepareEntity(categoryModel: CategoryModel) {
        id = Int16(categoryModel.id)
        name = categoryModel.name
    }
}

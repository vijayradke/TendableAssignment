//
//  AreaEntity+CoreDataClass.swift
//  Tendable
//
//  Created by Vijay Radake.
//
//

import Foundation
import CoreData

@objc(AreaEntity)
public class AreaEntity: NSManagedObject {

    func prepareEntity(areaModel: AreaModel) {
        id = Int16(areaModel.id)
        name = areaModel.name
    }
}

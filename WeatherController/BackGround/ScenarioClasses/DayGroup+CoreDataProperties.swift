//
//  DayGroup+CoreDataProperties.swift
//  
//
//  Created by Mikhail Chibrin on 31.01.2022.
//
//

import Foundation
import CoreData


extension DayGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayGroup> {
        return NSFetchRequest<DayGroup>(entityName: "DayGroup")
    }

    @NSManaged public var days: [Int]?
    @NSManaged public var setting0: Setting?
    @NSManaged public var setting1: Setting?

}

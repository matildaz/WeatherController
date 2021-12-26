//
//  Day_Group+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//
//

import Foundation
import CoreData


extension Day_Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day_Group> {
        return NSFetchRequest<Day_Group>(entityName: "Day_Group")
    }

    @NSManaged public var days: [Int]?
    @NSManaged public var setting0: Setting?
    @NSManaged public var setting1: Setting?

}

extension Day_Group : Identifiable {

}

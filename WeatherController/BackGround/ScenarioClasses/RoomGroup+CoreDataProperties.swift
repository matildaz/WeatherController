//
//  RoomGroup+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 31.01.2022.
//
//

import Foundation
import CoreData


extension RoomGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoomGroup> {
        return NSFetchRequest<RoomGroup>(entityName: "RoomGroup")
    }

    @NSManaged public var rIDs: [Int]?
    @NSManaged public var dayGroup0: DayGroup?
    @NSManaged public var dayGroup1: DayGroup?

}

extension RoomGroup : Identifiable {

}

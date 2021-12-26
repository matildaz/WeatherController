//
//  RoomGroup+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
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

    func makeRoomGroupStructure() -> [RoomGroupStructure]? {
        let roomGroupStructure = RoomGroupStructure(rIDs: self.rIDs, dayGroup0: self.dayGroup0?.makeDayGroupStruct(), dayGroup1: self.dayGroup1?.makeDayGroupStruct())
        return [roomGroupStructure]
    }
    
}

extension RoomGroup : Identifiable {

}

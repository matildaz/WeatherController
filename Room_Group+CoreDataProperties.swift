//
//  Room_Group+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//
//

import Foundation
import CoreData


extension Room_Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Room_Group> {
        return NSFetchRequest<Room_Group>(entityName: "Room_Group")
    }

    @NSManaged public var rIDs: [Int]?
    @NSManaged public var day_Group0: Day_Group?
    @NSManaged public var day_Group1: Day_Group?
    
    func makeRoomGroupStructure() -> [RoomGroupStructure]? {
        let roomGroupStructure = RoomGroupStructure(rIDs: self.rIDs, dayGroup0: self.day_Group0?.makeDayGroupStruct(), dayGroup1: self.day_Group1?.makeDayGroupStruct())
        return [roomGroupStructure]
    }


}

extension Room_Group : Identifiable {

}

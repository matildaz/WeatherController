//
//  CurrentRoomClass+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 02.02.2022.
//
//

import Foundation
import CoreData


extension CurrentRoomClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentRoomClass> {
        return NSFetchRequest<CurrentRoomClass>(entityName: "CurrentRoomClass")
    }

    @NSManaged public var co2: String?
    @NSManaged public var roomName: String?
    @NSManaged public var temperature: String?
    @NSManaged public var wet: String?

}

extension CurrentRoomClass : Identifiable {

}

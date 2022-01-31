//
//  Script+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 31.01.2022.
//
//

import Foundation
import CoreData


extension Script {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Script> {
        return NSFetchRequest<Script>(entityName: "Script")
    }

    @NSManaged public var did: String?
    @NSManaged public var name: String?
    @NSManaged public var discription: String?
    @NSManaged public var roomGroop0: RoomGroup?

}

extension Script : Identifiable {

}

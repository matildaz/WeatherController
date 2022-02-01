//
//  ScriptNSMO+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 01.02.2022.
//
//

import Foundation
import CoreData


extension ScriptNSMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScriptNSMO> {
        return NSFetchRequest<ScriptNSMO>(entityName: "ScriptNSMO")
    }

    @NSManaged public var did: String?
    @NSManaged public var discription: String?
    @NSManaged public var name: String?
    @NSManaged public var roomGroop0: RoomGroup?

}

extension ScriptNSMO : Identifiable {

}

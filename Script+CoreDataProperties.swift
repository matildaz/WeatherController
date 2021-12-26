//
//  Script+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
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
    @NSManaged public var roomGroop0: RoomGroup?

    func makeTheStructure() -> ScriptSctructure? {
        let scenario = ScriptSctructure(did: Int(self.did!)!, name: self.name, roomGroop0: self.roomGroop0?.makeRoomGroupStructure())
        return scenario
    }

}

extension Script : Identifiable {

}

//
//  MainUser+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//
//

import Foundation
import CoreData


extension MainUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainUser> {
        return NSFetchRequest<MainUser>(entityName: "MainUser")
    }

    @NSManaged public var did: Int64

}

extension MainUser : Identifiable {

}

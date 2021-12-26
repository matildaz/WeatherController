//
//  Setting+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//
//

import Foundation
import CoreData


extension Setting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setting> {
        return NSFetchRequest<Setting>(entityName: "Setting")
    }

    @NSManaged public var at_home: Int64
    @NSManaged public var co2: Int64
    @NSManaged public var dont_use: [Int]?
    @NSManaged public var hum: Int64
    @NSManaged public var must_use: [Int]?
    @NSManaged public var mute: Int64
    @NSManaged public var temp: Int64
    @NSManaged public var time: String?
    
    func makeSettingStructure() -> [SettingStructure]? {
        let settingStructure = SettingStructure(at_home: self.at_home, co2: self.co2, dont_use: self.dont_use, hum: self.hum, must_use: self.must_use, mute: self.mute, temp: self.temp, time: self.time)
        return [settingStructure]
    }
    
}

extension Setting : Identifiable {

}

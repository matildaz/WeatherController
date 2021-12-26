//
//  DayGroup+CoreDataProperties.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//
//

import Foundation
import CoreData


extension DayGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayGroup> {
        return NSFetchRequest<DayGroup>(entityName: "DayGroup")
    }

    @NSManaged public var days: [Int]?
    @NSManaged public var setting0: Setting?
    @NSManaged public var setting1: Setting?

    func makeDayGroupStruct() -> [DayGroupStructure]? {
        
        var dayGroupStructure = DayGroupStructure(days: self.days, setting0: nil, setting1: nil)
        if self.setting0 != nil {
            dayGroupStructure.setting0 = self.setting0?.makeSettingStructure()
        } else if self.setting1 != nil {
            dayGroupStructure.setting1 = self.setting1?.makeSettingStructure()
        }
        return [dayGroupStructure]
    }
    
}

extension DayGroup : Identifiable {

}

//
//  RoomGroupStructure.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation

struct RoomGroupStructure : Codable {
    
    var rIDs: [Int]?
    var dayGroup0: DayGroupStructure?
    var dayGroup1: DayGroupStructure?
    
}

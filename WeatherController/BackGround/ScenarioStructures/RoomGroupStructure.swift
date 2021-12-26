//
//  RoomGroupStructure.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation

struct RoomGroupStructure : Codable {
    
    var rIDs: [Int]?
    var day_Group0: [DayGroupStructure]?
    var day_Group1: [DayGroupStructure]?
    
}

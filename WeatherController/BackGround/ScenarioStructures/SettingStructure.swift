//
//  SettingStructure.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation

struct SettingStructure : Codable {
    
    var at_home: Int
    var co2: Int
    var dont_use: [Int]?
    var hum: Int
    var must_use: [Int]?
    var mute: Int
    var temp: Int
    var time: String?
    
}

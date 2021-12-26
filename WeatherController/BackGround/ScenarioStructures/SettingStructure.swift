//
//  SettingStructure.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation

struct SettingStructure : Codable {
    
    var at_home: Int64
    var co2: Int64
    var dont_use: [Int]?
    var hum: Int64
    var must_use: [Int]?
    var mute: Int64
    var temp: Int64
    var time: String?
    
}

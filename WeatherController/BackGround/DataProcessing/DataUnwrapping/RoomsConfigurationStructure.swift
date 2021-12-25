//
//  RoomsConfigurationStructure.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import Foundation
import SwiftyJSON

struct RoomConfigurationStruct : Codable {
    var r_name : String
    var rid: Int
}

struct DatchikConfigurationStruct : Codable {
    var rid: Int
    var dt: String?
    var temp: Int?
    var temp_valve: Int?
    var co2: Int?
    var hum: Int?
    var people: Int?
}

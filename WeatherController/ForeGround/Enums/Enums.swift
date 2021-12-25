//
//  Enums.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//

import Foundation

enum Information {
    case roomScripts
    case roomConfiguration
    case datchikConfiguration
}

enum NetworkSensorError: Error {
    case badData
    case badEncodingJSON
    case errorForRequest
    case badUrl
}

enum TypeOfSensor {
    case current
    case aim
}

enum NetworkError: Error {
    case badData
    case badEncoding
    case errorForRequest
    case badUrl
}

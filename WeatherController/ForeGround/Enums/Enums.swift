//
//  Enums.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//

import Foundation

// Collecting the info
enum Information {
    case roomScripts
    case roomConfiguration
    case datchikConfiguration
    case testScripts
}

// Errors
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

// Errors
enum NetworkError: Error {
    case badData
    case badEncoding
    case errorForRequest
    case badUrl
}

// Scenario variants
enum ScenarioVariant {
    case custom
    case def
}

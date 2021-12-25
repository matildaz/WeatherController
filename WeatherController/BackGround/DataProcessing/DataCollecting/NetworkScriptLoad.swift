//
//  NetworkScriptLoad.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import UIKit
import SwiftyJSON

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

class NetworkScriptLoad {

    private var scriptsDataDict: [String: JSON] = [:]

    func getDataScripts<T>(completion: @escaping (Result<T, NetworkSensorError>) -> Void) {
        guard let url = URL(string: "https://back.vc-app.ru/app/get_scripts?did=10155") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if UserDefaults.standard.object(forKey: "UserEmail") as? String == "apple" {
            request.setValue(self.authorizationTokenYan(), forHTTPHeaderField: "Authorization")
        } else {
            request.setValue(self.authorizationToken(), forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) {data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.errorForRequest))
                }
                return
            }

            if let data = data {
                if let decodedData = JSON(data).dictionary {
                        for (key, data) in decodedData {
                            self.scriptsDataDict[key] = data
                        }
                        if let scriptsDataDict = self.scriptsDataDict as? T {
                            DispatchQueue.main.async {
                                completion(.success(scriptsDataDict))
                            }
                        }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.badEncodingJSON))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.badData))
                }
            }
        }.resume()
    }
    func authorizationToken() -> String {
        return "Yandex AgAAAAADcss4AAa-id41yBOKBEgdgHgz7ew8mP4"
    }
    func authorizationTokenYan() -> String {
        return "Yandex AgAAAAADcss4AAa-id41yBOKBEgdgHgz7ew8mP4"
    }
}

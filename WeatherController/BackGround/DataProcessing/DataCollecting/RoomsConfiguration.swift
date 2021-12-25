//
//  RoomsConfiguration.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import Foundation
import SwiftyJSON

class RoomConfiguration {
    
    private var roomConfigDict: [String: RoomConfigurationStruct] = [:]
    
    func getConfig<T>(completion: @escaping (Result<T ,NetworkSensorError>) -> Void) {
        guard let url = URL(string: "https://back.vc-app.ru/app/rm_config?did=10155") else {
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
                    completion(.failure(.badUrl))
                }
                return
            }
            if let data = data {
                if let decodedData = JSON(data).dictionary {
                        for (key, data) in decodedData {
                            if key != "did" {
                                let roomScript = RoomConfigurationStruct (r_name: data["r_name"].stringValue, rid: data["rid"].intValue)
                                self.roomConfigDict[key] = roomScript
                            }
                        }
                        if let scriptsDataDict = self.roomConfigDict as? T {
                            DispatchQueue.main.async {
                                completion(.success(scriptsDataDict))
                            }
                        }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.badEncodingJSON))
                }
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

//
//  DatchikConfiguration.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//

//TODO: - Сервер находится в доработке, поэтому скрипт еще не дописан

import Foundation
import SwiftyJSON

class DatchikConfiguration {
    
    private var DatchikConfigDict: [String: JSON] = [:]
    
    func getConfig<T>(did: Int, completion: @escaping (Result<T ,NetworkSensorError>) -> Void) {
        guard let url = URL(string: "https://back.vc-app.ru/app/datchik?did=\(did)") else {
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
                let decodedData = JSON(data).dictionary
                print(decodedData)
                DispatchQueue.main.async {
                    completion(.failure(.badUrl))
                }
//                            DispatchQueue.main.async {
//                                completion(.success())
//                            }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.badEncodingJSON))
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

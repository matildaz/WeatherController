//
//  CheckTheScenarioStatus.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 25.12.2021.
//

import Foundation
import SwiftyJSON

class CheckTheScenarioStatus {
    func CheckTheScenarioStatus(did: Int) {
        guard let url = URL(string: "https://back.vc-app.ru/app/script_cur?did=\(did)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if UserDefaults.standard.object(forKey: "UserEmail") as? String == "apple" {
            request.setValue(self.authorizationTokenYan(), forHTTPHeaderField: "Authorization")
        } else {
            request.setValue(self.authorizationToken(), forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard error == nil else {
                return
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

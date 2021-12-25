//
//  NetworkScript.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import UIKit
import SwiftyJSON

class NetworkScript {
    func sentDataScript(script: JSON) {
        guard let url = URL(string: "https://\(Bundle.main.infoDictionary?["SENT_DATA"] as? String ?? "")") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if UserDefaults.standard.object(forKey: "UserEmail") as? String == "apple" {
            request.setValue(self.authorizationTokenYan(), forHTTPHeaderField: "Authorization")
        } else {
            request.setValue(self.authorizationToken(), forHTTPHeaderField: "Authorization")
        }

        let encoder = JSONEncoder()
        if let data = try? encoder.encode(script) {
            request.httpBody = data
            URLSession.shared.dataTask(with: request) {data, _, error in
                guard error == nil else {
                    return
                }
            }.resume()
        }
    }
    func authorizationToken() -> String {
        return "Yandex AgAAAAADcss4AAa-id41yBOKBEgdgHgz7ew8mP4"
    }
    func authorizationTokenYan() -> String {
        return "Yandex AgAAAAADcss4AAa-id41yBOKBEgdgHgz7ew8mP4"
    }
}

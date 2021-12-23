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
                    print("error with sending data")
                    return
                }

                if let data = data {
                    if let data = String(bytes: data, encoding: .utf8) {
                        print("!")
                        print(data)
                        print("!")
                    }
                } else {
                    print("badData for script")
                    return
                }
            }.resume()
        }
    }
    func authorizationToken() -> String {
        guard let token = UserDefaults.standard.object(forKey: "Token") as? String else {
            return ""
        }
        return "Yandex AgAAAAADcss4AAa-id41yBOKBEgdgHgz7ew8mP4"
//        return "Google" + " " + token
    }
    func authorizationTokenYan() -> String {
        guard let token = UserDefaults.standard.object(forKey: "Token") as? String else {
            return ""
        }
        return "Yandex" + " " + "AgAAAAAaGAgvAAa-ictSVhJT0UkruSzpJe4JCos"
    }
}

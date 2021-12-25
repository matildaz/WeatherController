//
//  TempretureChange.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import Foundation
import SwiftyJSON

class ChangeTemp {

    func tempretureChange(roomID: Int, temperature: Int, completion :@escaping () -> Void) {
        guard let url = URL(string: "https://back.vc-app.ru/app/ch_temp?did=10155&rid=\(roomID)&ch_temp=\(temperature)") else {
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
                    print(NetworkSensorError.errorForRequest)
                }
                return
            }
            if data != nil {
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    print(NetworkSensorError.badData)
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

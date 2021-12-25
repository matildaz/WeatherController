//
//  ViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.12.2021.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var scriptsDict: [Int: String] = [:]
    var currentScript = 0
    var arrayDict: [(key: Int, value: String)]?
    var roomsConfiguration: [String: RoomConfigurationStruct] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        loadInformation(typeOfInformation: .roomScripts)
        loadInformation(typeOfInformation: .roomConfiguration)
        loadInformation(typeOfInformation: .datchikConfiguration)
    }
    
    func loadScripts(group: DispatchGroup) {
        let loadScripts = NetworkScriptLoad()
        loadScripts.getDataScripts { (result: Result<[String: JSON], NetworkSensorError>) in
            self.scriptsDict.removeAll()
            switch result {
            case .success(let result):
                for data in result {
                    if data.key == "cur" {
                        if let valueInt = data.value.int {
                            self.currentScript = valueInt
                        }
                    } else {
                        if let intData = Int(data.key) {
                            self.scriptsDict[intData] = data.value.string
                        }
                    }
                }
                print(self.scriptsDict)
                group.leave()
            case .failure(let error):
                print(#line,#function)
                print(error.localizedDescription)
                group.leave()
            }
        }
    }
    
    func loadRoomConfiguration(group: DispatchGroup) {
        let loadRoomScripts = RoomConfiguration()
        loadRoomScripts.getConfig{ (result: Result<[String: RoomConfigurationStruct], NetworkSensorError>) in
            self.roomsConfiguration.removeAll()
            switch result {
            case .success(let result):
                self.roomsConfiguration = result
                print(self.roomsConfiguration)
                group.leave()
            case .failure(let error):
                print(#line,#function)
                print(error.localizedDescription)
                group.leave()
            }
        }
    }
    
    func loadDatchikConfiguration(group: DispatchGroup) {
        let datchikConfiguration = DatchikConfiguration()
        datchikConfiguration.getConfig{ (result: Result<[String:JSON], NetworkSensorError>) in
            switch result {
            case .success(let result):
                print(result)
                group.leave()
            case .failure(let error):
                print(error)
                group.leave()
            }
        }
    }
    
    func loadInformation(typeOfInformation: Information) {
        let group = DispatchGroup()
        switch typeOfInformation {
        case .roomConfiguration:
            group.enter()
            DispatchQueue.main.async {
                self.loadRoomConfiguration(group: group)
            }
        case .roomScripts:
            group.enter()
            DispatchQueue.main.async {
                self.loadScripts(group: group)
            }
        case .datchikConfiguration:
            group.enter()
            DispatchQueue.main.async {
                self.loadDatchikConfiguration(group: group)
            }
        }
    }

}


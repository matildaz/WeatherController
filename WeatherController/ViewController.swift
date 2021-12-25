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
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
            //self.loadScripts(group: group)
            self.loadRoomScripts(group: group)
        }
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
                print(result)
                print("1!")
                group.leave()
            case .failure(let error):
                print("444")
                print(error.localizedDescription)
                group.leave()
            }
        }
    }
    
    func loadRoomScripts(group: DispatchGroup) {
        let loadRoomScripts = RoomConfiguration()
        loadRoomScripts.getConfig{ (result: Result<[String: RoomConfigurationStruct], NetworkSensorError>) in
            self.scriptsDict.removeAll()
            switch result {
            case .success(let result):
                self.roomsConfiguration = result
                print(self.roomsConfiguration)
                group.leave()
            case .failure(let error):
                print("444")
                print(error.localizedDescription)
                group.leave()
            }
        }
    }

}


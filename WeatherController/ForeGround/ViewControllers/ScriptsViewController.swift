//
//  ScriptsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 05.01.2022.
//

import UIKit
import SwiftyJSON

class ScriptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    @IBOutlet weak var scriptTableView: UITableView!
    var scriptsDict: [Int: String] = [:]
    var currentScript = 0
    var arrayDict: [(key: Int, value: String)]?
    var roomsConfiguration: [String: RoomConfigurationStruct] = [:]
    var roomsDatchikConfiguration: [Int: DatchikConfigurationStruct] = [:]
    let did = 10155
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scriptsDict[0] = "Лето"
        self.scriptsDict[1] = "Межсезонье"
        self.scriptsDict[2] = "Зима"
        self.scriptsDict[3] = "Отпуск"
//        loadInformation(typeOfInformation: .testScripts)
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
    }
    
    @IBAction func refreshButtonGetPressed(_ sender: Any) {
        loadInformation(typeOfInformation: .testScripts)
    }
    
    func loadScripts(group: DispatchGroup) {
        let loadScripts = NetworkScriptLoad()
        loadScripts.getDataScripts(did: self.did) { (result: Result<[String: JSON], NetworkSensorError>) in
            self.scriptsDict.removeAll()
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
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
        loadRoomScripts.getConfig(did: self.did){ (result: Result<[String: RoomConfigurationStruct], NetworkSensorError>) in
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
        datchikConfiguration.getConfig(did: self.did){ (result: Result<[String:JSON], NetworkSensorError>) in
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
            let newDatchik0 = DatchikConfigurationStruct(rid: 47, dt: "2020-11-27 00:56:41", temp: 31, temp_valve: nil, co2: 456, hum: 77, people: 1)
            let newDatchik1 = DatchikConfigurationStruct(rid: 48, dt: "2020-11-27 06:56:41", temp: 23, temp_valve: nil, co2: 345, hum: 78, people: 2)
            let newDatchik2 = DatchikConfigurationStruct(rid: 49, dt: "2020-11-27 10:56:41", temp: 26, temp_valve: nil, co2: 567, hum: 79, people: 3)
            self.roomsDatchikConfiguration[newDatchik0.rid] = newDatchik0
            self.roomsDatchikConfiguration[newDatchik1.rid] = newDatchik1
            self.roomsDatchikConfiguration[newDatchik2.rid] = newDatchik2
            print(self.roomsDatchikConfiguration)
            //MARK: - пока не доступен запрос - пользуюсь костылем
//            group.enter()
//            DispatchQueue.main.async {
//                self.loadDatchikConfiguration(group: group)
        case .testScripts:
            DispatchQueue.main.async {
                self.scriptsDict[0] = "Лето"
                self.scriptsDict[1] = "Межсезонье"
                self.scriptsDict[2] = "Зима"
                self.scriptsDict[3] = "Отпуск"
            }
        }
        }
    
    //MARK: TableViewFunks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let scriptCell = tableView.dequeueReusableCell(withIdentifier: "ScriptTableViewCell", for: indexPath) as? ScriptTableViewCell {
            scriptCell.configure(scriptName: scriptsDict[indexPath.row] ?? "Лето", scriptDescription: scriptsDict[indexPath.row] ?? "Лето")
            scriptCell.imageView?.image = UIImage(named: "peopleDark")
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

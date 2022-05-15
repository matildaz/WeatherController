//
//  JsonDataClass.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 15.05.2022.
//

import Foundation
import SwiftyJSON

class JsonDataClass {
    
    public func getNewData() -> [Int : RoomStruct]? {
        if let path = Bundle.main.path(forResource: "../data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                var roomDict: [Int : RoomStruct] = [:]
                for room in jsonObj {
                    let dataItem = room.1
                    let newRoom = RoomStruct(hum: dataItem["hum"].rawValue as! String,
                                             name: dataItem["name"].rawValue as! String,
                                             co2: dataItem["co2"].rawValue as! String,
                                             rId: room.0,
                                             temp: dataItem["temp"].rawValue as! String,
                                             people: dataItem["people"].rawValue as! String,
                                             date: dataItem["date"].rawValue as! String)
                    roomDict[Int(newRoom.rId)!] = newRoom
                    }
                return roomDict
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("Invalid filename/path.")
            return nil
        }
    }
    
    public func getOldData() -> [Int : RoomStruct]? {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = URL(fileURLWithPath: "data", relativeTo: directoryURL).appendingPathExtension("json")
        do {
            let data = try Data(contentsOf: fileURL, options: .alwaysMapped)
            let jsonObj = try JSON(data: data)
            var roomDict: [Int : RoomStruct] = [:]
            for room in jsonObj {
                let dataItem = room.1
                let newRoom = RoomStruct(hum: dataItem["hum"].rawValue as! String,
                                         name: dataItem["name"].rawValue as! String,
                                         co2: dataItem["co2"].rawValue as! String,
                                         rId: room.0,
                                         temp: dataItem["temp"].rawValue as! String,
                                         people: dataItem["people"].rawValue as! String,
                                         date: dataItem["date"].rawValue as! String)
                roomDict[Int(newRoom.rId)!] = newRoom
                }
            return roomDict
        } catch let error {
            print("Error getting data. \(error)")
            return nil
        }
    }
    
    public func compareData(oldDictionary: [Int : RoomStruct], newDictionary: [Int : RoomStruct]) -> [Int : RoomStruct] {
        var dataDictionary : [Int : RoomStruct] = oldDictionary
        for key in newDictionary.keys {
            dataDictionary[key] = newDictionary[key]
        }
        return dataDictionary
    }
    
    public func saveData(dictionary: [Int: RoomStruct]) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = URL(fileURLWithPath: "data", relativeTo: directoryURL).appendingPathExtension("json")
        var stringToSave = """
                            {
                            """
        for key in dictionary.keys {
            let jsonString = """
                                "\(key)" : {
                                    "date" : "\(String((dictionary[key]?.date)!))",
                                    "people" : "\(String((dictionary[key]?.people)!))",
                                    "co2" : "\(String((dictionary[key]?.co2)!))",
                                    "rId" : "\(String((dictionary[key]?.rId)!))",
                                    "hum" : "\(String((dictionary[key]?.hum)!))",
                                    "temp" : "\(String((dictionary[key]?.temp)!))",
                                    "name" : "\(String((dictionary[key]?.name)!))"
                                  },
                            """
            stringToSave += jsonString
        }
        stringToSave.popLast()
        stringToSave += "}"
        do {
            try stringToSave.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch let error {
            print("Error with saving. \(error)")
        }
    }
}

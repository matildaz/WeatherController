//
//  CurrentRoomViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import Foundation
import UIKit

class CurrentRoomViewController: UIViewController {
    
    var currentRoom = RoomStructure(roomName: "test", roomTemperature: "test", roomWet: "test", roomCO2: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheAtributes()
    }
    
    func setTheAtributes() {
        // Colors
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        
        // NavigationBar
        navigationItem.title = currentRoom.roomName
        navigationItem.backButtonTitle = "Все комнаты"
    }
    
}

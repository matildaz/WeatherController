//
//  TestViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 17.01.2022.
// 

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var roomName: UITextField!
    @IBOutlet weak var temperature: UITextField!
    @IBOutlet weak var wet: UITextField!
    @IBOutlet weak var co2: UITextField!
    var rooms: [CurrentRoomClass] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonGotPressed(_ sender: UIButton) {
        if (roomName.text?.isEmpty == false && temperature.text?.isEmpty == false && wet.text?.isEmpty == false && co2.text?.isEmpty == false) {
            //addNewRoom(name: roomName.text!, temperature: Int64(temperature.text!)!, wet: wet.text!, co2: co2.text!)
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Test creator", message: "You have not filled all the rows", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func fetchCurrentRooms() {
        do {
            self.rooms = try context.fetch(CurrentRoomClass.fetchRequest())
        } catch {
            print("Saving error")
        }
    }
    
//    func addNewRoom(name: String, temperature: Int64, wet: String, co2: String) {
//        let newRoom = CurrentRoomClass(context: self.context)
//        newRoom.roomName = name
//        newRoom.co2 = co2
//        newRoom.wet = wet
//        newRoom.temperature = temperature
//        print(newRoom)
//        print(rooms)
//        do {
//            try self.context.save()
//        }
//        catch {
//            print("error in add")
//        }
//        // reload info
//        self.fetchCurrentRooms()
//    }
    
}

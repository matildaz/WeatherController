//
//  CurrentRoomViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import Foundation
import UIKit

class CurrentRoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //DatchikCollectionViewCell
    //TemperatureChangeCollectionViewCell
    
    var currentRoom = RoomStructure(roomName: "test", roomTemperature: "test", roomWet: "test", roomCO2: "test")
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
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
        
        // CollectionView
        roomCollectionView.delegate = self
        roomCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        roomCollectionView.collectionViewLayout = layout
        roomCollectionView.backgroundColor = UIColor.init(_colorLiteralRed: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        roomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        roomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomWet, image: UIImage(named: "humidity")!)
                cell = roomCell
            }
        case 1 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomTemperature, image: UIImage(named: "temperature")!)
                cell = roomCell
            }
        case 2 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureChangeCollectionViewCell", for: indexPath) as? TemperatureChangeCollectionViewCell {
                roomCell.configure(with: currentRoom.roomTemperature)
                cell = roomCell
            }
        case 3 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: "1 человек", image: UIImage(named: "people")!)
                cell = roomCell
            }
        case 4 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomCO2, image: UIImage(named: "corbonDioxide")!)
                cell = roomCell
            }
        default:
            return cell
        }
        return cell
    }
    
    
}

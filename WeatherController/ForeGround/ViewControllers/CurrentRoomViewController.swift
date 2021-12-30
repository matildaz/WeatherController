//
//  CurrentRoomViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import Foundation
import UIKit
import DSCircularCollectionView

class CurrentRoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //DatchikCollectionViewCell
    //TemperatureChangeCollectionViewCell
    //3*M_PI_2+M_PI/6, endAngle: 7*M_PI_2+M_PI/6
    
    var currentRoom = RoomStructure(roomName: "test", roomTemperature: "test", roomWet: "test", roomCO2: "test")
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
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
//        roomCollectionView.isScrollEnabled = false
        roomCollectionView.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        roomCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        roomCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let radius = 2*(self.view.bounds.midX)/3
        let centre = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        let xDeviation = radius*sin(Double.pi/3)
        let yDeviation = radius*cos(Double.pi/3)
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomWet, image: UIImage(named: "humidity")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y+yDeviation)
                cell = roomCell
            }
        case 1 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomTemperature, image: UIImage(named: "temperature")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 2 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureChangeCollectionViewCell", for: indexPath) as? TemperatureChangeCollectionViewCell {
                roomCell.configure(with: currentRoom.roomTemperature)
                roomCell.layer.position = CGPoint(x: centre.x, y: centre.y-radius)
                cell = roomCell
            }
        case 3 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: "1 человек", image: UIImage(named: "people")!)
                roomCell.layer.position = CGPoint(x: centre.x+xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 4 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.roomCO2, image: UIImage(named: "corbonDioxide")!)
                roomCell.layer.position = CGPoint(x: centre.x+xDeviation, y: centre.y+yDeviation)
                cell = roomCell
            }
        default:
            return cell
        }
        cell.layer.cornerRadius = cell.frame.height/2
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension CurrentRoomViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize = CGSize()
        if indexPath.row == 2 {
            itemSize = CGSize(width: 140, height: 70)
        } else {
            itemSize = CGSize(width: self.view.bounds.midX/2.5, height: self.view.bounds.midX/2.5)
        }
        return itemSize
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let inset: CGFloat = 20
//        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
}

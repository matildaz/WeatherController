//
//  MainViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let kitchen = RoomStructure(roomName: "Kitchen", roomTemperature: "24", roomWet: "75", roomCO2: "456")
    let livingRoom = RoomStructure(roomName: "Living room", roomTemperature: "24", roomWet: "60", roomCO2: "345")
    let kitchen1 = RoomStructure(roomName: "Kitchen", roomTemperature: "24", roomWet: "75", roomCO2: "456")
    let livingRoom1 = RoomStructure(roomName: "Living efwefun qpwfrufn room", roomTemperature: "24", roomWet: "60", roomCO2: "345")
    var rooms: [RoomStructure] = []
    private var safeArea: UILayoutGuide!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        setTheViewController()
        addSMTH()
    }
    
    func addSMTH() {
        self.rooms.append(self.kitchen)
        self.rooms.append(self.livingRoom)
        self.rooms.append(self.kitchen1)
        self.rooms.append(self.livingRoom1)
    }
    
    func setTheViewController() {
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = UIColor.init(_colorLiteralRed: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        mainCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    //MARK: Working with collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewControllerCell", for: indexPath) as? CollectionViewCell {
            roomCell.configure(withName: self.rooms[indexPath.row].roomName, withTemp: self.rooms[indexPath.row].roomTemperature, withWet: self.rooms[indexPath.row].roomWet, withCO2: self.rooms[indexPath.row].roomCO2)
            roomCell.peopleImageView.image = UIImage(named: "people")
            cell = roomCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let constrain: CGFloat = 10
        return constrain
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let constrain: CGFloat = 10
        return constrain
    }
}

extension RoomsViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 20
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

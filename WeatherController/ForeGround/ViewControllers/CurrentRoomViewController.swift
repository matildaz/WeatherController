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
    
    var currentRoom = CurrentRoomClass()
    private var safeArea: UILayoutGuide!
    @IBOutlet weak var roomCollectionView: UICollectionView!
    private var stackView: UIStackView!
    @IBOutlet weak var ventilationButton: UIButton!
    @IBOutlet weak var plusTempButton: UIButton!
    @IBOutlet weak var minusTempButton: UIButton!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        tabBarController?.tabBar.backgroundColor = UIColor(red: 0.867, green: 0.918, blue: 0.953, alpha: 1)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.867, green: 0.918, blue: 0.953, alpha: 1)
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        setTheAtributes()
        setTheButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roomCollectionView.reloadData()
    }
    
    @IBAction func plusTemp(_ sender: Any) {
        if var temp = Int(currentRoom.temperature!) {
            if temp < 30 {
                temp += 1
                currentRoom.temperature = String(temp)
                fetchCurrentRoom()
            }
        }
    }
    
    @IBAction func minusTemp(_ sender: Any) {
        if var temp = Int(currentRoom.temperature!) {
            if temp > 16 {
                temp -= 1
                currentRoom.temperature = String(temp)
                fetchCurrentRoom()
            }
        }
    }
    
    func fetchCurrentRoom() {
        do {
            try currentRoom.managedObjectContext?.save()
            
            DispatchQueue.main.async {
                self.roomCollectionView.reloadData()
            }
        } catch {
            print("Saving error")
        }
    }
    
    func setTheButtons() {
        let plusMinusWidth = self.view.bounds.midX/4.5
        let radius = 3*(safeArea.layoutFrame.midX)/4
        let centre = CGPoint(x: self.safeArea.layoutFrame.midX/2, y: self.safeArea.layoutFrame.midY-radius)
        let cellWidth = self.view.bounds.midX/2.5
        
        // Ventilation button
        let buttonWidth = self.view.bounds.midX/1.3
        ventilationButton.frame.size = CGSize(width: buttonWidth, height: buttonWidth)
        ventilationButton.layer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        ventilationButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        ventilationButton.layer.cornerRadius = buttonWidth/2
        ventilationButton.titleLabel?.textAlignment = .center
        ventilationButton.titleLabel?.textColor = .white
        
        // Plus Temp button
        plusTempButton.frame.size = CGSize(width: plusMinusWidth, height: plusMinusWidth)
        plusTempButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        plusTempButton.layer.cornerRadius = plusMinusWidth/2
        plusTempButton.titleLabel?.text = "+"
        plusTempButton.titleLabel?.textColor = .white
        // Minus Temp button
        minusTempButton.frame.size = CGSize(width: plusMinusWidth, height: plusMinusWidth)
        minusTempButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        minusTempButton.layer.cornerRadius = plusMinusWidth/2
        minusTempButton.titleLabel?.text = "-"
        minusTempButton.titleLabel?.textColor = .white
        // StackView
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.layer.position = CGPoint(x: centre.x, y: centre.y - plusMinusWidth/4)
        stackView.frame.size = CGSize(width: safeArea.layoutFrame.midX, height: plusMinusWidth)
        stackView.spacing = cellWidth*1.4
        stackView.addArrangedSubview(plusTempButton)
        stackView.addArrangedSubview(minusTempButton)
        self.view.addSubview(stackView)
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
        
        let radius = 3*(safeArea.layoutFrame.midX)/4
        let centre = CGPoint(x: self.safeArea.layoutFrame.midX, y: 0.8*self.safeArea.layoutFrame.midY)
        let edge = CGPoint(x: self.safeArea.layoutFrame.maxX, y: self.safeArea.layoutFrame.maxY)
        let xDeviation = radius*sin(Double.pi/3)
        let yDeviation = radius*cos(Double.pi/3)
        var cell = UICollectionViewCell()
        switch indexPath.row {
        case 0 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.wet!, image: UIImage(named: "humidityDark")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y+yDeviation)
                cell = roomCell
            }
        case 1 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.temperature!, image: UIImage(named: "temperatureDark")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 2 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureChangeCollectionViewCell", for: indexPath) as? TemperatureChangeCollectionViewCell {
                roomCell.configure(with: currentRoom.temperature!)
                roomCell.layer.position = CGPoint(x: centre.x, y: centre.y-radius)
                cell = roomCell
            }
        case 3 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: "1 человек", image: UIImage(named: "peopleDark")!)
                roomCell.layer.position = CGPoint(x: centre.x+xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 4 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom.co2!, image: UIImage(named: "carbonDioxideDark")!)
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
        let itemSize = CGSize(width: self.view.bounds.midX/2.5, height: self.view.bounds.midX/2.5)
        return itemSize
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let inset: CGFloat = 20
//        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
}

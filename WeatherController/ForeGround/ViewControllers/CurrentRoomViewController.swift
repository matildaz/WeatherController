//
//  CurrentRoomViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import Foundation
import UIKit

class CurrentRoomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var changeTemperatureLabel: UILabel!
    var currentRoom: RoomStruct?
    let JSONDataClass = JsonDataClass()
    private var safeArea: UILayoutGuide!
    @IBOutlet weak var roomCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var roomLable: UILabel!
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
    
    func saveData() {
        var oldDictionary = JSONDataClass.getOldData()
        oldDictionary = JSONDataClass.compareData(oldDictionary: oldDictionary!, newDictionary: [Int((currentRoom?.rId)!)!: currentRoom!])
        JSONDataClass.saveData(dictionary: oldDictionary!)
        roomCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        roomCollectionView.reloadData()
    }
    
    @IBAction func plusTemp(_ sender: Any) {
        if var temp = Int((currentRoom?.temp)!) {
            if temp < 30 {
                temp += 1
                currentRoom?.temp = String(temp)
                saveData()
            }
        }
    }
    
    @IBAction func minusTemp(_ sender: Any) {
        if var temp = Int((currentRoom?.temp)!) {
            if temp > 16 {
                temp -= 1
                currentRoom?.temp = String(temp)
                saveData()
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
//    func fetchCurrentRoom() {
//        do {
//            try currentRoom.managedObjectContext?.save()
//
//            DispatchQueue.main.async {
//                self.roomCollectionView.reloadData()
//            }
//        } catch {
//            print("Saving error")
//        }
//    }
    
    func setTheButtons() {
        let plusMinusWidth = self.view.bounds.midX/4.5
        let radius = 3*(safeArea.layoutFrame.midX)/4
        let centre = CGPoint(x: self.safeArea.layoutFrame.midX/2, y: self.safeArea.layoutFrame.midY-radius)
        let cellWidth = self.view.bounds.midX/2.5
        
        // CurrentRoomLabel
        roomLable.font = UIFont(name: "Inter-SemiBold", size: 16)
        roomLable.text = currentRoom?.name
        
        // Ventilation button
        let buttonWidth = self.view.bounds.midX/1.3
        ventilationButton.frame.size = CGSize(width: buttonWidth, height: buttonWidth)
        ventilationButton.layer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY - 5/3*plusMinusWidth)
        ventilationButton.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        ventilationButton.layer.cornerRadius = buttonWidth/2
        ventilationButton.titleLabel?.textAlignment = .center
        ventilationButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        ventilationButton.setTitle(ventilationButton.titleLabel?.text, for: .normal)
        ventilationButton.tintColor = .white
        
        // Plus Temp button
        plusTempButton.frame.size = CGSize(width: 2*plusMinusWidth, height: 2*plusMinusWidth)
//        plusTempButton.layer.backgroundColor = UIColor.gray.cgColor
        plusTempButton.setImage(UIImage(named: "plusButton-1"), for: .normal)
        
        // Minus Temp button
        minusTempButton.frame.size = CGSize(width: 2*plusMinusWidth, height: 2*plusMinusWidth)
//        minusTempButton.layer.backgroundColor = UIColor.gray.cgColor
        minusTempButton.setImage(UIImage(named: "minusButton-1"), for: .normal)
        
        // StackView
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.layer.position = CGPoint(x: centre.x, y: centre.y/2 + plusMinusWidth) //- plusMinusWidth/4)
        stackView.frame.size = CGSize(width: safeArea.layoutFrame.midX, height: plusMinusWidth)
        stackView.spacing = cellWidth*1.4
        stackView.addArrangedSubview(plusTempButton)
        stackView.addArrangedSubview(minusTempButton)
        mainView.addSubview(stackView)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY - 5/3*plusMinusWidth), radius: 2*radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.borderWidth = 3
        shapeLayer.borderColor = UIColor(red: 9/255, green: 152/255, blue: 255/255, alpha: 0.4).cgColor
        
        mainView.layer.insertSublayer(shapeLayer, at: 0)
        mainView.backgroundColor = .white
        
        changeTemperatureLabel.font = UIFont(name: "Inter-SemiBold", size: 24)
        changeTemperatureLabel.text = "Изменить температуру"
        changeTemperatureLabel.textColor = UIColor(red: 0.137, green: 0.282, blue: 0.651, alpha: 1)
        changeTemperatureLabel.layer.position = CGPoint(x: centre.x-3/4*plusMinusWidth, y: centre.y/2)
        changeTemperatureLabel.frame.size = CGSize(width: 300, height: 30)
        changeTemperatureLabel.textAlignment = .center
        
//        mainView.layer.addSublayer(shapeLayer)
//        mainView.addSubview(stackView)
//        mainView.addSubview(roomCollectionView)
//        mainView.addSubview(ventilationButton)
    }
    
    func setTheAtributes() {
        // Colors
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        
        // NavigationBar
        
        // CollectionView
        roomCollectionView.delegate = self
        roomCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        roomCollectionView.collectionViewLayout = layout
//        roomCollectionView.isScrollEnabled = false
        roomCollectionView.backgroundColor = .none
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
                roomCell.configure(text: currentRoom!.hum, image: UIImage(named: "humidityDarkBlue")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y+yDeviation)
                cell = roomCell
            }
        case 1 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom!.temp, image: UIImage(named: "temperatureDarkBlue")!)
                roomCell.layer.position = CGPoint(x: centre.x-xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 2 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureChangeCollectionViewCell", for: indexPath) as? TemperatureChangeCollectionViewCell {
                roomCell.configure(with: currentRoom!.temp)
                roomCell.layer.position = CGPoint(x: centre.x, y: centre.y-radius)
                roomCell.TemperatureLableView.textColor = UIColor(red: 1, green: 0.651, blue: 0.353, alpha: 1)
                roomCell.TemperatureLableView.font = UIFont(name: "Inter-SemiBold", size: 16)
                cell = roomCell
            }
        case 3 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom!.people, image: UIImage(named: "peopleDarkBlue")!)
                roomCell.layer.position = CGPoint(x: centre.x+xDeviation, y: centre.y-yDeviation)
                cell = roomCell
            }
        case 4 :
            if let roomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DatchikCollectionViewCell", for: indexPath) as? DatchikCollectionViewCell {
                roomCell.configure(text: currentRoom!.co2, image: UIImage(named: "CO2DarkBlue")!)
                roomCell.layer.position = CGPoint(x: centre.x+xDeviation, y: centre.y+yDeviation)
                cell = roomCell
            }
        default:
            return cell
        }
        cell.layer.cornerRadius = cell.frame.height/2
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 9/255, green: 152/255, blue: 255/255, alpha: 0.4).cgColor
        return cell
    }
}

extension CurrentRoomViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: self.view.bounds.midX/2.5, height: self.view.bounds.midX/2.5)
        return itemSize
    }
}

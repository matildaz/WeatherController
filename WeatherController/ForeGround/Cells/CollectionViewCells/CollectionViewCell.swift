//
//  CollectionViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    var currentRoom: String?
    
    @IBOutlet weak var numberOfPeopleInRoom: UILabel!
    
    @IBOutlet weak var peopleImageView: UIImageView!
    @IBOutlet weak var roomNameLable: UILabel!
    
    @IBOutlet weak var temperatureImageView: UIImageView!
    @IBOutlet weak var temperatureLableView: UILabel!
    
    @IBOutlet weak var wetImageView: UIImageView!
    @IBOutlet weak var wetLableView: UILabel!
    
    @IBOutlet weak var co2ImageView: UIImageView!
    @IBOutlet weak var co2LableView: UILabel!
    
    func setTheLables() {
        roomNameLable.text = "Room"
        temperatureLableView.text = "CurrTemp"
        wetLableView.text = "CurrWet"
        co2LableView.text = "CurrCO2"
    }
    
    func configure(withPeople numberOfPeople: String, withName roomName: String, withTemp temperature: String, withWet wet: String, withCO2 co2: String, rId: String) {
        
        numberOfPeopleInRoom.text = numberOfPeople
        numberOfPeopleInRoom.textColor = UIColor(red: 1, green: 0.651, blue: 0.353, alpha: 1)
        numberOfPeopleInRoom.font = UIFont(name: "Inter-SemiBold", size: 16)
        roomNameLable.text = roomName
        roomNameLable.textColor = UIColor(red: 0.137, green: 0.282, blue: 0.651, alpha: 1)
        roomNameLable.font = UIFont(name: "Inter-SemiBold", size: 24)
        temperatureLableView.text = temperature
        temperatureLableView.textColor = .black
        temperatureLableView.font = UIFont(name: "Inter-SemiBold", size: 16)
        wetLableView.text = wet
        wetLableView.textColor = .black
        wetLableView.font = UIFont(name: "Inter-SemiBold", size: 16)
        co2LableView.text = co2
        co2LableView.textColor = .black
        co2LableView.font = UIFont(name: "Inter-SemiBold", size: 16)
        setTheCorners()
        
        self.currentRoom = rId
    }
    
//    let layerGradient = CAGradientLayer()
//    layerGradient.colors = [
//        UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor,
//      UIColor(red: 0.358, green: 0.384, blue: 1, alpha: 1).cgColor
//    ]
//    layerGradient.locations = [0.27, 0.79]
//    layerGradient.startPoint = CGPoint(x: 0.25, y: 0.5)
//    layerGradient.endPoint = CGPoint(x: 0.75, y: 0.5)
//    layerGradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.25, b: 0, c: 2.23, d: 5.52, tx: -1.11, ty: -2.26))
//    layerGradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//    layerGradient.position = view.center
//    blueView.layer.addSublayer(layerGradient)
    
    
    
    func setTheCorners() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        mainView.backgroundColor = UIColor(red: 0.969, green: 0.991, blue: 1, alpha: 1)
        mainView.layer.cornerRadius = 10
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(red: 9/255, green: 152/255, blue: 255/255, alpha: 0.4).cgColor
    }
    
    func setTheColorsAndStaticPictures() {
        self.peopleImageView.image = UIImage(named: "UnionpeopleYellow")
        self.temperatureImageView.image = UIImage(named: "temperature")
        self.wetImageView.image = UIImage(named: "humidity")
        self.co2ImageView.image = UIImage(named: "corbonDioxide")
    }
    
}

//
//  CollectionViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 26.12.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setTheCorners()
        setTheColorsAndStaticPictures()
    }
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
    
    func configure(withName roomName: String, withTemp temperature: String, withWet wet: String, withCO2 co2: String) {
        roomNameLable.text = roomName
        temperatureLableView.text = temperature
        wetLableView.text = wet
        co2LableView.text = co2
    }
    
    func setTheCorners() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
    }
    
    func setTheColorsAndStaticPictures() {
        self.temperatureImageView.image = UIImage(named: "temperature")
        self.wetImageView.image = UIImage(named: "humidity")
        self.co2ImageView.image = UIImage(named: "corbonDioxide")
        self.backgroundColor = UIColor(red: 0.749, green: 0.831, blue: 0.894, alpha: 1)
    }
    
}

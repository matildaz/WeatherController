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
        setTheLables()
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
    
    
}

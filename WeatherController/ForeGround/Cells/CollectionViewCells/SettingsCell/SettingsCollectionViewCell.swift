//
//  SettingsCollectionViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 23.10.2022.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var toggle = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // default
        setView(imageWhite: "fan", imageBlue: "fanBlue")
        // Initialization code
    }
    
    func setView(imageWhite: String, imageBlue: String) {
        if !toggle {
            self.layer.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            self.layer.borderColor = .none
            self.layer.borderWidth = 0
            imageView.image = UIImage(named: imageWhite)
        } else {
            self.backgroundColor = .white
            self.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            self.layer.borderWidth = 2
            imageView.image = UIImage(named: imageBlue)
        }
    }

}

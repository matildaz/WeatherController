//
//  DatchikCollectionViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import UIKit

class DatchikCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var datchikLableView: UILabel!
    @IBOutlet weak var datchikImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setTheCorners()
    }
    
    func configure(text: String, image: UIImage) {
        datchikLableView.text = text
        datchikLableView.font = UIFont(name: "Inter-SemiBold", size: 16)
        datchikImageView.image = image
    }
    
    func setTheCorners() {
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 9/255, green: 152/255, blue: 255/255, alpha: 0.4).cgColor
    }
}

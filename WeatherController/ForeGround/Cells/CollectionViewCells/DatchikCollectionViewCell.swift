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
    
    func configure(text text: String, image image: UIImage) {
        datchikLableView.text = text
        datchikImageView.image = image
    }
    
    func setTheCorners() {
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = false
    }
}

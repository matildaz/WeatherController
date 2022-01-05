//
//  TemperatureChangeCollectionViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 28.12.2021.
//

import UIKit

class TemperatureChangeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var TemperatureLableView: UILabel!
    
    var roomID: Int?
    var did: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setTheCorners()
    }
    
    func setTheCorners() {
        self.layer.cornerRadius =  10
        self.layer.masksToBounds = false
    }
    
    //TODO: добавить цельсии
    func configure(with temperature: String) {
        TemperatureLableView.text = temperature
    }
    
//    @IBAction func minusTemp(_ sender: Any) {
//        if roomID != nil && did != nil {
//            var temp = Int(TemperatureLableView.text!)!
//            temp -= 1
//            let request = ChangeTemp()
//            request.tempretureChange(roomID: roomID!, temperature: temp, did: did!, completion: {})
//            TemperatureLableView.text = String(temp)
//        }
//    }
//
//    @IBAction func plusTemp(_ sender: Any) {
//        if roomID != nil && did != nil {
//            var temp = Int(TemperatureLableView.text!)!
//            if temp <= 29 {
//                temp += 1
//                let request = ChangeTemp()
//                request.tempretureChange(roomID: roomID!, temperature: temp, did: did!, completion: {})
//                TemperatureLableView.text = String(temp)
//            } // TODO: прописать выбрасывание ошибки, тип максимальная темпа
//        }
//    }
}

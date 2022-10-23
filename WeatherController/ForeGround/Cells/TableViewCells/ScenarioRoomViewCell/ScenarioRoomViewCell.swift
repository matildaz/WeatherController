//
//  ScenarioRoomViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 02.02.2022.
//

import UIKit

class ScenarioRoomViewCell: UITableViewCell {
    
    @IBOutlet weak var tikButton: UIButton!
    @IBOutlet weak var roomLable: UILabel!
    var toggle = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setButton() {
        tikButton.layer.borderWidth = 1
        tikButton.layer.cornerRadius = 5
        tikButton.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
        tikButton.imageView?.image = .none
    }
    
    @IBAction func tikButtonPressed(_ sender: UIButton) {
        toggle.toggle()
        if toggle == true {
            self.tikButton.setImage(UIImage(named:"VectorSemiBold"), for: .normal)
            self.tikButton.layer.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
        } else {
            self.tikButton.setImage(.none, for: .normal)
            self.tikButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        }
        
    }
    
}

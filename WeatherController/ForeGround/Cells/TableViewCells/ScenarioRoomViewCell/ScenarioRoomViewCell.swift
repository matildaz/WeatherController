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
        tikButton.layer.borderColor = UIColor.black.cgColor
        tikButton.imageView?.image = .none
    }
    
    @IBAction func tikButtonPressed(_ sender: UIButton) {
        toggle.toggle()
        if toggle == true {
            self.tikButton.layer.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1).cgColor
        } else {
            self.tikButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        }
        
    }
}

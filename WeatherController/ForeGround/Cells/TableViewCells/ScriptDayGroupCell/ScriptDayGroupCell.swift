//
//  ScriptDayGroupCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 15.02.2022.
//

import UIKit

class ScriptDayGroupCell: UITableViewCell {
    
    @IBOutlet weak var daysLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillTheLable (days: [Int]) {
        daysLable.text = ""
        for (index, item) in days.enumerated() {
            switch item {
            case 1:
            daysLable.text! += "Пн"
            case 2:
            daysLable.text! += "Вт"
            case 3:
            daysLable.text! += "Ср"
            case 4:
            daysLable.text! += "Чт"
            case 5:
            daysLable.text! += "Пт"
            case 6:
            daysLable.text! += "Сб"
            case 7:
            daysLable.text! += "Вс"
            default:
                continue
            }
            if index != days.count - 1 {
                daysLable.text! += ", "
            }
        }
    }
    
}

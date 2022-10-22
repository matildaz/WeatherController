//
//  ScriptTableViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 05.01.2022.
//

import UIKit

class ScriptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(scriptName: String, scriptDescription: String) {
        nameLable.text = scriptName
        nameLable.font = UIFont(name: "Inter-SemiBold", size: 20)
        descriptionLable.text = scriptDescription
        descriptionLable.font = UIFont(name: "Inter-Italic", size: 16)
    }

}

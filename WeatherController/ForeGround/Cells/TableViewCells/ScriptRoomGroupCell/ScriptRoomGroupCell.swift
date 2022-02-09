//
//  ScriptRoomGroupCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 09.02.2022.
//

import UIKit

class ScriptRoomGroupCell: UITableViewCell {

    
    @IBOutlet weak var roomLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addRoom(room: RoomGroupStructure) {
        for i in room.rIDs! {
            if i == room.rIDs![0] {
                roomLable.text! += String(i)
            } else {
                roomLable.text! += ", "
                roomLable.text! += String(i)
            }
        }
    }
}

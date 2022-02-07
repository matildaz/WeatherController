//
//  ScenarioRoomsView.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 02.02.2022.
//

import UIKit

class ScenarioRoomsView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var rooms = [CurrentRoomClass]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var background: UIView?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setBounds(view: UIView) {
        // width
        let width = 3*view.frame.size.width/4
        
        // Add ScenarioView buttons
        self.frame = CGRect(x: view.frame.midX - width/2, y: view.frame.midY - width/2, width: width, height: 2*width/3)
        self.layer.cornerRadius = 16
        self.buttonSet()
        
        // background
        background = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height))
        background?.backgroundColor = .black
        background?.alpha = 0.6
        // addSubview
        background?.addSubview(self)
    }
    
    /**
     button layer
     */
    func buttonSet() {
        // Cancel button
        cancelButton.titleLabel?.textColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.cornerRadius = (cancelButton?.frame.height)!/2
        
        // Submit button
        submitButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        submitButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.removeFromSuperview()
        background?.removeFromSuperview()
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    // table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let roomCell = UINib(nibName: "ScenarioRoomViewCell", bundle: .main).instantiate(withOwner: nil, options: nil).first as? ScenarioRoomViewCell {
            roomCell.roomLable.text = rooms[indexPath.row].roomName!
            cell = roomCell
        }
        return cell
    }
    
    
}

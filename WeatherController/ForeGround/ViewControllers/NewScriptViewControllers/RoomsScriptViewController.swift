//
//  DaysScriptViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 03.02.2022.
//

import UIKit

class RoomsScriptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // main view
    @IBOutlet weak var roomsTableView: UITableView!
    @IBOutlet weak var addNewRoomGroupButton: UIButton!
    @IBOutlet weak var submitExitButton: UIButton!
    
    // selection view
    @IBOutlet weak var roomSelectTableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var roomSelectView: UIView!
    var firstTime = true
    
    
    var newScript: ScriptSctructure?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var roomGroupsDict: [RoomGroupStructure] = []
    var roomDict: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        roomSelectTableView.delegate = self
        roomSelectTableView.dataSource = self
        setView()
        testAppend()
        roomsTableView.reloadData()
        print(newScript!.scriptName!)
    }
    
    func testAppend() {
        roomGroupsDict.append(RoomGroupStructure(rIDs: [1,2,3,4,5,12], dayGroup0: nil, dayGroup1: nil))
        roomGroupsDict.append(RoomGroupStructure(rIDs: [1,4,7,3,2], dayGroup0: nil, dayGroup1: nil))
        roomsTableView.reloadData()
        let elements = ["1","2","3","4","5","6","12"]
        roomDict += elements
        roomSelectTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoomGroupSegue" {
            let targetVC = segue.destination as! DaysViewController
            targetVC.newScript = self.newScript
        }
    }
    
    func setView() {
        // tabBar
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        // View
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        
        mainButtonSet()
    }
    
    func mainButtonSet() {
        // Buttons
        submitExitButton.tintColor = .gray
        
        addNewRoomGroupButton.tintColor = .white
        addNewRoomGroupButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        addNewRoomGroupButton.layer.cornerRadius = (submitButton?.frame.height)!/2
    }
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        backViewIsEnabled()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        var arrayOfRooms: [Int] = []
        for row in 0...self.roomDict.count-1 {
            let cell = roomSelectTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ScenarioRoomViewCell
            if cell.toggle {
                arrayOfRooms.append(Int(roomDict[row])!)
                cell.tikButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                cell.toggle.toggle()
            }
        }
        roomGroupsDict.append(RoomGroupStructure(rIDs: arrayOfRooms, dayGroup0: nil, dayGroup1: nil))
        roomsTableView.reloadData()
        backViewIsDisabled()
    }
    
    @IBAction func submitExitButtonPressed(_ sender: UIButton) {
        mainButtonSet()
        // TODO: save
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == roomsTableView {
            return roomGroupsDict.count
        } else {
            return roomDict.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == roomsTableView {
            if let roomGroupCell = tableView.dequeueReusableCell(withIdentifier: "ScriptRoomGroupCell") as? ScriptRoomGroupCell {
                roomGroupCell.roomLable.text = ""
                roomGroupCell.addRoom(room: roomGroupsDict[indexPath.row])
                roomGroupCell.layer.cornerRadius = 5
                cell = roomGroupCell
            }
        } else {
            if let roomSelectCell = UINib(nibName: "ScenarioRoomViewCell", bundle: .main).instantiate(withOwner: nil, options: nil).first as? ScenarioRoomViewCell {
                roomSelectCell.roomLable.text = roomDict[indexPath.row]
                cell = roomSelectCell
            }
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == roomsTableView {
            let height = self.view.frame.height/12
            return height
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newScript?.roomGroop0 = roomGroupsDict[indexPath.row]
        print(newScript)
        // do smth, save roomGroup
        performSegue(withIdentifier: "RoomGroupSegue", sender: self)
    }
}

extension RoomsScriptViewController {
    
    func backViewIsEnabled() {
        if firstTime {
            setBackground()
            buttonSet()
            self.roomSelectView.layer.cornerRadius = 16
            let width = self.view.frame.size.width
            
            // Add ScenarioView buttons
            roomSelectView.frame = CGRect(x: view.frame.midX - width/2, y: view.frame.midY - width/2, width: width, height: 2*width/3)
            firstTime = false
        }
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.backgroundView.alpha = 0.6
            self.roomSelectView.alpha = 1
        })
    }
    
    func backViewIsDisabled() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.backgroundView.alpha = 0
            self.roomSelectView.alpha = 0
        })
    }
    
    func setBackground() {
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        roomSelectView.backgroundColor = .white
        roomSelectView.alpha = 0
    }
    
    func buttonSet() {
        // Submit button
        submitButton.tintColor = .white
        submitButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
    }
}


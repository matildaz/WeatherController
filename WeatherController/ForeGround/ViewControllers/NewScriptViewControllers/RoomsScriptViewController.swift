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
    
    
    let JSONDataClass = JsonDataClass()
    var newScript: ScriptSctructure?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // roomGroupsDict - Массив из RoomGroupStructure на главном экране
    var roomGroupsDict: [RoomGroupStructure] = []
    // roomDict - Словарь из значений [ID комнаты : Название комнаты]
    var roomDict: [Int : String] = [:]
    
    var roomDataDict: [Int: RoomStruct] = [:]
    var rootVC: ScriptsViewController?
    
    
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
        getData()
        for (index, itemValue) in roomDataDict {
            roomGroupsDict.append(RoomGroupStructure(rIDs: [index], dayGroup0: nil, dayGroup1: nil))
            roomDict[index] = itemValue.name
        }
        
        roomSelectTableView.reloadData()
    }
    
    func getData() {
        if let oldDictionary = JSONDataClass.getOldData() {
            roomDataDict = oldDictionary
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoomGroupSegue" {
            let targetVC = segue.destination as! DaysViewController
            targetVC.newScript = self.newScript
            targetVC.rootVC = self.rootVC
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
        submitExitButton.setImage(UIImage(named: "VectorDarkSemiBold"), for: .normal)
        submitExitButton.setTitle(.none, for: .normal)
        addNewRoomGroupButton.tintColor = .white
        addNewRoomGroupButton.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        addNewRoomGroupButton.layer.cornerRadius = (addNewRoomGroupButton?.frame.height)!/2
    }
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        backViewIsEnabled()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        var arrayOfRooms: [Int: String] = [:]
        for row in 0...self.roomDict.count-1 {
            let cell = roomSelectTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! ScenarioRoomViewCell
            if cell.toggle {
                arrayOfRooms[row] = roomDict[row]
                cell.tikButton.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                cell.toggle.toggle()
            }
        }
        var array: [Int] = []
        for itemValue in arrayOfRooms.keys {
            array.append(itemValue)
        }
        roomGroupsDict.append(RoomGroupStructure(rIDs: array, dayGroup0: nil, dayGroup1: nil))
        roomsTableView.reloadData()
        backViewIsDisabled()
    }
    
    @IBAction func submitExitButtonPressed(_ sender: UIButton) {
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
                roomGroupCell.addRoom(room: roomGroupsDict[indexPath.row], dict: roomDict)
                roomGroupCell.layer.cornerRadius = 5
                cell = roomGroupCell
            }
        } else {
            if let roomSelectCell = UINib(nibName: "ScenarioRoomViewCell", bundle: .main).instantiate(withOwner: nil, options: nil).first as? ScenarioRoomViewCell {
                roomSelectCell.roomLable.text = String(roomDict[indexPath.row]!)
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
            return 40
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
            self.roomSelectView.backgroundColor = .white
            self.backgroundView.alpha = 0.6
            self.roomSelectView.alpha = 2
//            self.backgroundView.addSubview(self.roomSelectView)
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
        submitButton.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
    }
}


//
//  ScriptsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 05.01.2022.
//

import UIKit
import SwiftyJSON

class ScriptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    @IBOutlet weak var scriptTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var ScriptView: UIView!
    
    var scriptsDict: [ScriptSctructure] = []
    var firstTime = true
    var newScript: ScriptSctructure?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Variables for add view
    private var addButton: UIButton?
    @IBOutlet weak var addViewLable: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
        test()
        testDisable()
//        fetchNewScript()
        setView()
        addButtonSet()
        scriptTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addButton?.removeFromSuperview()
        addButtonSet()
        scriptTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scriptTableView.reloadData()
    }
    
    func test() {
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "Отпуск", scriptDescription: "Энергосберегающий режим", roomGroop0: RoomGroupStructure(rIDs: [0,1,2], dayGroup0: DayGroupStructure(days: [1,2,3,4,5], setting0: SettingStructure(at_home: 0, co2: 0, dont_use: [1,1,1,1], hum: 0, must_use: [0,0,0,0], mute: 1, temp: 22, time: nil), setting1: SettingStructure(at_home: 0, co2: 0, dont_use: [1,1,1,1], hum: 0, must_use: [0,0,0,0], mute: 0, temp: 22, time: nil)), dayGroup1: nil)))
        
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "Дома", scriptDescription: "Приток кислорода", roomGroop0: RoomGroupStructure(rIDs: [0,1,2], dayGroup0: DayGroupStructure(days: [1,2,3,4,5], setting0: SettingStructure(at_home: 1, co2: 0, dont_use: [0,1,0,0], hum: 0, must_use: [1,0,1,1], mute: 0, temp: 22, time: nil), setting1: SettingStructure(at_home: 0, co2: 0, dont_use: [0,1,0,0], hum: 0, must_use: [1,0,1,1], mute: 0, temp: 22, time: nil)), dayGroup1: nil)))
        
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "Стандартный", scriptDescription: "Стандарт", roomGroop0: RoomGroupStructure(rIDs: [0,1,2], dayGroup0: DayGroupStructure(days: [1,2,3,4,5], setting0: SettingStructure(at_home: 0, co2: 0, dont_use: [0,0,0,0], hum: 0, must_use: [1,1,1,1], mute: 0, temp: 22, time: nil), setting1: SettingStructure(at_home: 0, co2: 0, dont_use: [0,0,0,0], hum: 0, must_use: [1,1,1,1], mute: 0, temp: 22, time: nil)), dayGroup1: nil)))
        
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "Тихий", scriptDescription: "Тихий стандарт", roomGroop0: RoomGroupStructure(rIDs: [0,1,2], dayGroup0: DayGroupStructure(days: [1,2,3,4,5], setting0: SettingStructure(at_home: 1, co2: 0, dont_use: [0,0,0,0], hum: 0, must_use: [1,1,1,1], mute: 1, temp: 22, time: nil), setting1: SettingStructure(at_home: 0, co2: 0, dont_use: [0,0,0,0], hum: 0, must_use: [1,1,1,1], mute: 1, temp: 22, time: nil)), dayGroup1: nil)))
        
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "Зимний", scriptDescription: "Подогрев", roomGroop0: RoomGroupStructure(rIDs: [0,1,2], dayGroup0: DayGroupStructure(days: [1,2,3,4,5], setting0: SettingStructure(at_home: 1, co2: 0, dont_use: [0,0,1,1], hum: 0, must_use: [1,1,0,0], mute: 0, temp: 22, time: nil), setting1: SettingStructure(at_home: 0, co2: 0, dont_use: [0,0,1,1], hum: 0, must_use: [1,1,0,0], mute: 0, temp: 22, time: nil)), dayGroup1: nil)))
        scriptTableView.reloadData()
    }
    
    func addButtonSet() {
        addButton = UIButton(frame: CGRect(x: self.view.bounds.maxX - self.view.frame.height/10, y: self.view.bounds.maxY - self.view.frame.height/5, width: self.view.frame.height/12, height: self.view.frame.height/12))
        addButton?.layer.cornerRadius = (addButton?.frame.width)!/2
        addButton?.setTitle("+", for: .normal)
        addButton?.titleLabel?.textColor = .white
        addButton?.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 48)
        addButton?.titleLabel?.textAlignment = .center
        addButton?.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        addButton?.addTarget(self, action: #selector(add_Button_Pressed), for: .touchUpInside)
        self.view.addSubview(addButton!)
    }
    
    func setView() {
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewScriptRoomSelector" {
            let destinationVC = segue.destination as! RoomsScriptViewController
            newScript?.scriptName = addTextField.text
            newScript?.did = "10155"
            newScript?.scriptDescription = ""
            newScript?.roomGroop0 = nil
            destinationVC.newScript = self.newScript
            destinationVC.rootVC = self
        }
        if segue.identifier == "showDetails" {
            let destinationVC = segue.destination as! ScenarioSettingsViewController
            let row = scriptTableView.indexPathForSelectedRow?.row
            let script = scriptsDict[row!]
            let rowNumber = row!
            scriptTableView.deselectRow(at: scriptTableView.indexPathForSelectedRow!, animated: true)
            destinationVC.script = script
            destinationVC.rowNamber = rowNumber
            destinationVC.rootVC = self
        }
    }
    
    func fetchNewScript() {
//        do {
//            self.scriptsDict = try context.fetch(ScenarioClass.fetchRequest())
//            DispatchQueue.main.async {
//                self.scriptTableView.reloadData()
//            }
//        } catch {
//            print("error")
//        }
    }
    
    func testDisable() {
        if firstTime {
            setBackground()
            buttonSet()
            self.ScriptView.layer.cornerRadius = 16
            let width = 3*self.view.frame.size.width/4
            
            // Add ScenarioView buttons
            ScriptView.frame = CGRect(x: view.frame.midX - width/2, y: view.frame.midY - width/2, width: width, height: 2*width/3)
        }
        UIView.animate(withDuration: 0, delay: 0, animations: {
            self.backgroundView.alpha = 0.6
            self.ScriptView.alpha = 1
        })
        UIView.animate(withDuration: 0, delay: 0, animations: {
            self.backgroundView.alpha = 0
            self.ScriptView.alpha = 0
        })
        
    }
    
    //MARK: - Buttons
    @objc func add_Button_Pressed(sender: UIButton) {
        addButton?.removeFromSuperview()
        backViewIsEnabled()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        backViewIsDisabled()
        addButtonSet()
        fetchNewScript()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if addTextField.text == "" {
            submitButton.titleLabel?.textColor = .white
        } else {
            newScript = ScriptSctructure(did: "10155", scriptName: addTextField.text, scriptDescription: "New Description", roomGroop0: nil)
            addTextField.text = ""
            scriptsDict.append(newScript!)
            // TODO: add automatic did
            fetchNewScript()
            backViewIsDisabled()
            self.performSegue(withIdentifier: "NewScriptRoomSelector", sender: self)
        }
    }
    
    //MARK: - TableViewFunks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let scriptCell = tableView.dequeueReusableCell(withIdentifier: "ScriptTableViewCell", for: indexPath) as? ScriptTableViewCell {
            scriptCell.configure(scriptName: scriptsDict[indexPath.row].scriptName!, scriptDescription: scriptsDict[indexPath.row].scriptDescription!)
            scriptCell.imageView?.image = UIImage(named: "scenarioIcon")
            print(scriptCell.isUserInteractionEnabled)
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height/12
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.visibleCells[indexPath.row]
        UIView.animate(withDuration: 0.05, delay: 0, animations: {
            cell.alpha = 0.5
            })
        UIView.animate(withDuration: 0.05, delay: 0, animations: {
            cell.alpha = 1
        })
        self.performSegue(withIdentifier: "showDetails", sender: self)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in

//            let script = self.scriptsDict[(indexPath as NSIndexPath).row] as ScriptSctructure
            self.scriptsDict.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
            tableView.reloadData()
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
       
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            // remove the item from the data model
//            self.scriptsDict.remove(at: indexPath.row)
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

extension ScriptsViewController {
    
    func backViewIsEnabled() {
        if firstTime {
            setBackground()
            buttonSet()
            self.ScriptView.layer.cornerRadius = 16
            let width = 3*self.view.frame.size.width/4
            
            // Add ScenarioView buttons
            ScriptView.frame = CGRect(x: view.frame.midX - width/2, y: view.frame.midY - width/2, width: width, height: 2*width/3)
        }
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.backgroundView.alpha = 0.6
            self.ScriptView.alpha = 1
        })
    }
    
    func backViewIsDisabled() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.backgroundView.alpha = 0
            self.ScriptView.alpha = 0
        })
    }
    
    func setBackground() {
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        ScriptView.backgroundColor = .white
        ScriptView.alpha = 0
    }
    
    /**
     button layer
     */
    func buttonSet() {
        // Cancel button
        cancelButton.titleLabel?.textColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.cornerRadius = (cancelButton?.frame.height)!/2
        
        // Submit button
        submitButton.titleLabel?.textColor = .white
        submitButton.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
    }
}

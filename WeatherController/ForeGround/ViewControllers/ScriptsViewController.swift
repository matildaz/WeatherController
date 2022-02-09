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
    @IBOutlet weak var addViewLable: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "name", scriptDescription: "New Description", roomGroop0: nil))
        scriptsDict.append(ScriptSctructure(did: "10155", scriptName: "not name", scriptDescription: "New Description", roomGroop0: nil))
//        fetchNewScript()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewScriptRoomSelector" {
            let destinationVC = segue.destination as! DaysScriptViewController
            destinationVC.newScript = self.newScript
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
    
    //MARK: - Buttons
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        backViewIsEnabled()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        backViewIsDisabled()
        fetchNewScript()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if addTextField.text == "" {
            return
        } else {
            newScript = ScriptSctructure(did: "10155", scriptName: addTextField.text, scriptDescription: "New Description", roomGroop0: nil)
            scriptsDict.append(newScript)
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
            scriptCell.imageView?.image = UIImage(named: "peopleDark")
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height/10
        return height
    }
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
}

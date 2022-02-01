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
    var scriptsDict: [ScriptNSMO] = []
    let scenarioView = UINib(nibName: "ScenarioNameView", bundle: .main).instantiate(withOwner: nil, options: nil).first as! ScenarioNameView
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptTableView.delegate = self
        scriptTableView.dataSource = self
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.scenarioView.setBounds(view: self.view)
        self.view.addSubview(self.scenarioView.background!)
    }
    
    //MARK: TableViewFunks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let scriptCell = tableView.dequeueReusableCell(withIdentifier: "ScriptTableViewCell", for: indexPath) as? ScriptTableViewCell {
            scriptCell.configure(scriptName: scriptsDict[indexPath.row].name!, scriptDescription: scriptsDict[indexPath.row].discription!)
            scriptCell.imageView?.image = UIImage(named: "peopleDark")
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
}

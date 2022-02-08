//
//  DaysScriptViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 03.02.2022.
//

import UIKit

class DaysScriptViewController: UIViewController {

    @IBOutlet weak var daysTableView: UITableView!
    @IBOutlet weak var addNewDayGroupButton: UIButton!
    
    var newScript: ScriptSctructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
    }
}

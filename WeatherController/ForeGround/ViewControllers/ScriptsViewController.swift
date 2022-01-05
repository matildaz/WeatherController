//
//  ScriptsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 05.01.2022.
//

import UIKit

class ScriptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    
    
    //MARK: Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: TableViewFunks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

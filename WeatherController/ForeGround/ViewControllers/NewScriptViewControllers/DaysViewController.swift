//
//  DaysViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 15.02.2022.
//

import UIKit

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets for main view
    //@IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dayGroupTableView: UITableView!
    @IBOutlet weak var submitExitButton: UIButton!
    @IBOutlet weak var addNewDayGroupButton: UIButton!
    
    // vars for main view
    var dayGroupDict: [DayGroupStructure] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayGroupTableView.delegate = self
        dayGroupTableView.dataSource = self
        setView()
        testAdd()
        //calculateTheConstrain()
        dayGroupTableView.reloadData()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        mainButtonSet()
        // TODO: save
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addNewDayGroupButtonPressed(_ sender: UIButton) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayGroupDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let dayGroupCell = UINib(nibName: "ScriptDayGroupCell", bundle: .main).instantiate(withOwner: nil, options: nil).first as? ScriptDayGroupCell {
            dayGroupCell.fillTheLable(days: self.dayGroupDict[indexPath.row].days!)
            cell = dayGroupCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(40)
        return height
    }
}

extension DaysViewController {
    
//    func calculateTheConstrain() {
//        var count = dayGroupDict.count * 40
//        count += Int(submitExitButton.frame.height)
//        count += Int(addNewDayGroupButton.frame.height)
//        count += 2 // spacing between items in stack
//        stackViewHeight.constant = CGFloat(count)
//    }
    
    func setView() {
        // tabBar
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        // View
        view.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
        
        mainButtonSet()
    }
    
    func mainButtonSet() {
        // Buttons
        submitExitButton.titleLabel?.textColor = .gray
        
        addNewDayGroupButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        addNewDayGroupButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        addNewDayGroupButton.layer.cornerRadius = 16
    }
    
    func testAdd() {
        for _ in 0...10 {
            let randNumber = Int.random(in: 1...6)
            let newDayGroup = DayGroupStructure(days: [randNumber,randNumber+1], setting0: nil, setting1: nil)
            dayGroupDict.append(newDayGroup)
        }
    }
}

//
//  DaysViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 15.02.2022.
//

import UIKit

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets for main view
    @IBOutlet weak var dayGroupTableView: UITableView!
    @IBOutlet weak var submitExitButton: UIButton!
    @IBOutlet weak var addNewDayGroupButton: UIButton!
    
    // Outlets for additional view
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var addWidth: NSLayoutConstraint!
    @IBOutlet weak var addHeight: NSLayoutConstraint!
    @IBOutlet var dayButtonCollection: [UIButton]!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var newDayGroupView: UIView!
    var firstTime: Bool = true
    
    // vars for main view
    var dayGroupDict: [DayGroupStructure] = []
    var newDayGroupArray: [String] = []
    var newScript: ScriptSctructure?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayGroupTableView.delegate = self
        dayGroupTableView.dataSource = self
        setView()
        //calculateTheConstrain()
        dayGroupTableView.reloadData()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        mainButtonSet()
        // TODO: save
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addNewDayGroupButtonPressed(_ sender: UIButton) {
        if firstTime {
            addButtonsSet()
        }
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.addViewWillAppear()
        })
    }
    
    @IBAction func submitNewDaysGroupButtonPressed(_ sender: UIButton) {
        var dayGroup0 = DayGroupStructure(days: [], setting0: nil, setting1: nil)
        var dayGroup1 = DayGroupStructure(days: [], setting0: nil, setting1: nil)
        for button in dayButtonCollection {
            var day: Int = 0
            switch button.titleLabel?.text {
            case "Пн":
                day = 1
            case "Вт":
                day = 2
            case "Ср":
                day = 3
            case "Чт":
                day = 4
            case "Пт":
                day = 5
            case "Сб":
                day = 6
            case "Вс":
                day = 7
            default:
                day = 0
            }
            if button.layer.backgroundColor == UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1).cgColor {
                dayGroup0.days?.append(day)
                button.layer.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1).cgColor
            } else {
                dayGroup1.days?.append(day)
            }
        }
        dayGroupDict.append(dayGroup0)
        dayGroupTableView.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.addViewWillDisappiar()
        })
    }
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        if (sender.layer.backgroundColor == UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1).cgColor) {
            DispatchQueue.main.async {
                sender.layer.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1).cgColor
                sender.tintColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
            }
        } else {
            DispatchQueue.main.async {
                sender.layer.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1).cgColor
                sender.tintColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1)
            }
        }
    }
    
    //--- table view ---//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayGroupDict.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newScript?.roomGroop0?.dayGroup0 = dayGroupDict[indexPath.row]
        print(newScript)
        //self.navigationController?.popToRootViewController(animated: true)
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
        
        addNewDayGroupButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        addNewDayGroupButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        addNewDayGroupButton.layer.cornerRadius = 16
    }
    
    func addButtonsSet() {
        // layer of days buttons
        for button in self.dayButtonCollection {
            button.layer.cornerRadius = button.frame.height/2
            button.layer.backgroundColor = UIColor(red: 0.949, green: 0.969, blue: 0.976, alpha: 1).cgColor
            button.tintColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
        }
        submitButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        submitButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
    }
    
    func addViewWillAppear() {
        if firstTime {
            newDayGroupView.layer.cornerRadius = 16
            firstTime = false
        }
        background.alpha = 0.6
        newDayGroupView.alpha = 1
    }
    
    func addViewWillDisappiar() {
        background.alpha = 0
        newDayGroupView.alpha = 0
    }
}

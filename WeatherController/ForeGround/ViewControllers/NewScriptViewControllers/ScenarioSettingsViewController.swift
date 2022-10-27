//
//  ScenarioSettingsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 06.04.2022.
//

import UIKit

class ScenarioSettingsViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // fields
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var CO2TextField: UITextField!
    @IBOutlet weak var wetTextField: UITextField!
    @IBOutlet weak var temperatureTextField: UITextField!
    
    // mode buttons
    @IBOutlet weak var nooneHomeButton: UIButton!
    @IBOutlet weak var doNotDisturbButton: UIButton!
    
    // mode buttons
    @IBOutlet var mustUseButtons: [UIButton]!
    @IBOutlet var doNotUseButtons: [UIButton]!
    
    @IBOutlet weak var MULable0: UILabel!
    @IBOutlet weak var MULable1: UILabel!
    @IBOutlet weak var MULable2: UILabel!
    @IBOutlet weak var MULable3: UILabel!
    
    @IBOutlet weak var NULable0: UILabel!
    @IBOutlet weak var NULable1: UILabel!
    @IBOutlet weak var NULable2: UILabel!
    @IBOutlet weak var NULable3: UILabel!
    
    // submit button
    @IBOutlet weak var submitButton: UIButton!
    
    // vars
    var rowNamber = 0
    var count_must = 0
    var count_dont = 0
    var mute: Int = 0
    var at_home: Int = 0
    var script: ScriptSctructure?
    var must_use: [Int] = [0,0,0,0]
    var dont_use: [Int] = [0,0,0,0]
    private var must_use_dict: [Int: Int] = [0:0, 1:0, 2:0, 3:0]
    private var dont_use_dict: [Int: Int] = [0:0, 1:0, 2:0, 3:0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsFromScript()
        uiViewSet()
    }
    
    func bag() {
        for button in mustUseButtons {
            button.layer.cornerRadius = button.frame.height/2
        }
        for button in doNotUseButtons {
            button.layer.cornerRadius = button.frame.height/2
        }
    }
    
    func uiViewSet() {
        setModeButtons()
        buttonSet()
        modeButtonsSet()
    }
    
    func settingsFromScript() {
        if let scriptSettings = script?.roomGroop0?.dayGroup0?.setting0 {
            descriptionTextView.text = script?.scriptDescription
            
            at_home = scriptSettings.at_home
            mute = scriptSettings.mute
            
            if scriptSettings.time != nil {
                dateTextField.text = scriptSettings.time
            }
            
            CO2TextField.text = String(scriptSettings.co2)
            wetTextField.text = String(scriptSettings.hum)
            temperatureTextField.text = String(scriptSettings.temp)
            
            must_use = scriptSettings.must_use ?? [0,0,0,0]
            dont_use = scriptSettings.dont_use ?? [0,0,0,0]
            
            var count = 0
            for _ in must_use {
                must_use_dict[count] = must_use[count]
                dont_use_dict[count] = dont_use[count]
                count += 1
            }
            
        }
    }
    
    
    @IBAction func nooneHomeButtonPressed(_ sender: Any) {
        if at_home == 0 {
            nooneHomeButton.setImage(UIImage(named: "atHome"), for: .normal)
            at_home = 1
        } else {
            nooneHomeButton.setImage(UIImage(named: "notAtHome"), for: .normal)
            at_home = 0
        }
    }
    
    @IBAction func doNotDisturbButtonPressed(_ sender: Any) {
        if mute == 0 {
            doNotDisturbButton.setImage(UIImage(named: "muteOn"), for: .normal)
            mute = 1
        } else {
            doNotDisturbButton.setImage(UIImage(named: "muteOff"), for: .normal)
            mute = 0
        }
    }
    
    @IBAction func mustUseButtonPressed(_ sender: UIButton) {
        must_use_dict[sender.tag]! += 1
        must_use_dict[sender.tag]! %= 2
        setModeButtons()
    }
    
    @IBAction func doNotUseButtonPressed(_ sender: UIButton) {
        dont_use_dict[sender.tag]! += 1
        dont_use_dict[sender.tag]! %= 2
        setModeButtons()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        must_use = []
        dont_use = []
        for (_,value) in must_use_dict {
            must_use.append(value)
        }
        for (_,value) in dont_use_dict {
            dont_use.append(value)
        }
        
        if var scriptSettings = script?.roomGroop0?.dayGroup0?.setting0 {
            script?.scriptDescription = descriptionTextView.text
            scriptSettings.at_home = at_home
            scriptSettings.dont_use = dont_use
            scriptSettings.must_use = must_use
            scriptSettings.mute = mute
//            scriptSettings.temp = temperatureTextField.text
//            scriptSettings.hum = wetTextField.text
//            scriptSettings.co2 = CO2TextField.text
            scriptSettings.time = dateTextField.text
        }
        
        let parent = parent?.presentingViewController as? ScriptsViewController
        parent?.scriptsDict[rowNamber] = script!
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setModeButtons() {
        for button in mustUseButtons {
            switch button.tag {
            case 0:
                if must_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 1:
                if must_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "heat"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "heatBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 2:
                if must_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 3:
                if must_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            default:
                button.setImage(UIImage(named: "fanBlue"), for: .normal)
                button.backgroundColor = .white
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            }
            if count_must < 4 {
                button.layer.cornerRadius = button.frame.height/3.2
                count_must += 1
            } else {
            button.layer.cornerRadius = button.frame.height/2
            }
        }
        
        for button in doNotUseButtons {
            switch button.tag {
            case 0:
                if dont_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 1:
                if dont_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "heat"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "heatBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 2:
                if dont_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            case 3:
                if dont_use_dict[button.tag] != 1 {
                    button.setImage(UIImage(named: "fan"), for: .normal)
                    button.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
                } else {
                    button.setImage(UIImage(named: "fanBlue"), for: .normal)
                    button.backgroundColor = .white
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
                }
            default:
                button.setImage(UIImage(named: "fanBlue"), for: .normal)
                button.backgroundColor = .white
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            }
            if count_dont < 4 {
                button.layer.cornerRadius = button.frame.height/3.2
                count_dont += 1
            } else {
                    button.layer.cornerRadius = button.frame.height/2
            }
        }
    }
    
    
}

extension ScenarioSettingsViewController {
    
    func buttonSet() {
        submitButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        submitButton.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
    }
    
    func modeButtonsSet() {
        nooneHomeButton.backgroundColor = .white
        if at_home == 0 {
            nooneHomeButton.setImage(UIImage(named: "notAtHome"), for: .normal)
        } else {
            nooneHomeButton.setImage(UIImage(named: "atHome"), for: .normal)
        }

        doNotDisturbButton.backgroundColor = .white
        if mute == 0 {
            doNotDisturbButton.setImage(UIImage(named: "muteOff"), for: .normal)
        } else {
            doNotDisturbButton.setImage(UIImage(named: "muteOn"), for: .normal)
        }
    }
    
}

/**
 if let settingsCell = UINib(nibName: "SettingsCollectionViewCell", bundle: .main).instantiate(withOwner: nil, options: nil).first as? SettingsCollectionViewCell {
         var imageName = ""
         switch indexPath.row {
         case 1:
             imageName += "heat"
         default:
             imageName += "fan"
         }
         switch must_use[indexPath.row] {
         case 1:
             imageName += "Blue"
         default:
             imageName += ""
         }
     settingsCell.imageView.image = UIImage(named: imageName)
     cell = settingsCell
 }
 */

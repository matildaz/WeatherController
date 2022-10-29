//
//  ScriptSettingsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 29.10.2022.
//

import UIKit

class ScriptSettingsViewController: UIViewController {

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
    
    // mode labels
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
    var count_must = 0
    var count_dont = 0
    var mute: Int = 0
    var at_home: Int = 0
    var newSscript: ScriptSctructure?
    var must_use: [Int] = [0,0,0,0]
    var dont_use: [Int] = [0,0,0,0]
    private var must_use_dict: [Int: Int] = [0:0, 1:0, 2:0, 3:0]
    private var dont_use_dict: [Int: Int] = [0:0, 1:0, 2:0, 3:0]
    var rootVC: ScriptsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViewSet()
    }
    
    func uiViewSet() {
        setModeButtons()
        buttonSet()
        modeButtonsSet()
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
        for (_,value) in must_use_dict.sorted(by: { $0.0 < $1.0 }) {
            must_use.append(value)
        }
        for (_,value) in dont_use_dict.sorted(by: { $0.0 < $1.0 }) {
            dont_use.append(value)
        }
        
        let scriptSettings = SettingStructure(at_home: self.at_home, co2: Int(self.CO2TextField.text!) ?? 460, dont_use: self.dont_use, hum: Int(self.wetTextField.text!) ?? 54, must_use: must_use, mute: self.mute, temp: Int(self.temperatureTextField.text!) ?? 22, time: self.dateTextField.text ?? "13.05")
        
        newSscript?.roomGroop0?.dayGroup0?.setting0 = scriptSettings
        newSscript?.scriptDescription = self.descriptionTextView.text ?? "#Description"
        rootVC?.scriptsDict[(rootVC?.scriptsDict.count)! - 1] = newSscript!
        
        self.navigationController?.popToRootViewController(animated: true)
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

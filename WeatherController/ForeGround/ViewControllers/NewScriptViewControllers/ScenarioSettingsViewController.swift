//
//  ScenarioSettingsViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 06.04.2022.
//

import UIKit

class ScenarioSettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // fields
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var CO2TextField: UITextField!
    @IBOutlet weak var wetTextField: UITextField!
    @IBOutlet weak var temperatureTextField: UITextField!
    
    // mode buttons
    @IBOutlet weak var nooneHomeButton: UIButton!
    @IBOutlet weak var doNotDisturbButton: UIButton!
    
    // mode collections
    @IBOutlet weak var useCollectionView: UICollectionView!
    @IBOutlet weak var doNotUseCollectionView: UICollectionView!
    
    // submit button
    @IBOutlet weak var submitButton: UIButton!
    
    // vars
    var mute: Int = 0
    var at_home: Int = 0
    var script: ScriptSctructure?
    var must_use: [Int] = []
    var dont_use: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.useCollectionView.delegate = self
        self.useCollectionView.dataSource = self
        self.doNotUseCollectionView.delegate = self
        self.doNotUseCollectionView.dataSource = self
        uiViewSet()
    }
    
    func uiViewSet() {
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
            
            if scriptSettings.at_home != 0 {
                nooneHomeButton.tintColor = .tintColor
                nooneHomeButton.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
                at_home = 1
            }
            
            if scriptSettings.mute != 0 {
                nooneHomeButton.tintColor = .tintColor
                nooneHomeButton.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
                at_home = 1
            }
            
            must_use = scriptSettings.must_use ?? [0,0,0,0]
            dont_use = scriptSettings.dont_use ?? [0,0,0,0]
        }
    }
    
    
    @IBAction func nooneHomeButtonPressed(_ sender: Any) {
        if at_home == 0 {
            nooneHomeButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            nooneHomeButton.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
            at_home = 1
        } else {
            nooneHomeButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            nooneHomeButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
            at_home = 0
        }
    }
    
    @IBAction func doNotDisturbButtonPressed(_ sender: Any) {
        if mute == 0 {
            mute = 1
            doNotDisturbButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            doNotDisturbButton.backgroundColor = UIColor(red: 0.349, green: 0.451, blue: 0.576, alpha: 1)
        } else {
            doNotDisturbButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            doNotDisturbButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
            mute = 0
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
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
        self.navigationController?.popViewController(animated: true)
    }
    
    //--- Collection views ---//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == useCollectionView {
            return 3
        } else if collectionView == doNotUseCollectionView {
            return 3
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension ScenarioSettingsViewController {
    
    func buttonSet() {
        submitButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        submitButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        submitButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
    }
    
    func modeButtonsSet() {
        
        nooneHomeButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        nooneHomeButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        nooneHomeButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        nooneHomeButton.layer.borderColor = UIColor.black.cgColor
        nooneHomeButton.layer.borderWidth = 2
        
        doNotDisturbButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        doNotDisturbButton.backgroundColor = UIColor(red: 0.196, green: 0.773, blue: 1, alpha: 1)
        doNotDisturbButton.layer.cornerRadius = (submitButton?.frame.height)!/2
        doNotDisturbButton.layer.borderColor = UIColor.black.cgColor
        doNotDisturbButton.layer.borderWidth = 2
        
    }
    
}

//
//  CurrentRoom5ViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 12.08.2022.
//

import Foundation
import UIKit

class CurrentRoom5ViewController: UIViewController {
    
    var currentRoom: RoomStruct?
    private var safeArea: UILayoutGuide!
    private var backgroundCircle: UIView?
    private var foregroundCircle: UIView?
    private var ventilationButton: UIButton?
    private var temperatureBackgroud: UIView?
    private var temperatureForeground: UIView?
    private var tempretureLable: UILabel?
    private var humidityBackgroud: UIView?
    private var humidityForeground: UIView?
    private var humidityLable: UILabel?
    private var peopleBackgroud: UIView?
    private var peopleoreground: UIView?
    private var peopleable: UILabel?
    private var temperatureBackgroud2: UIView?
    private var temperatureForeground2: UIView?
    private var co2Backgroud2: UIView?
    private var co2Foreground2: UIView?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        drawCirclesAndButtons()
        updateUI()
    }
    
    private func updateUI() {
    }
    
    private func drawCirclesAndButtons() {
        let point = CGPoint(x: self.safeArea.layoutFrame.maxX / 5, y: self.safeArea.layoutFrame.midY -  self.safeArea.layoutFrame.maxX / 3)
        let radius = 3*point.x
        
//        let plusMinusWidth = self.view.bounds.midX/4.5
//        let centre = CGPoint(x: self.safeArea.layoutFrame.midX/2, y: self.safeArea.layoutFrame.midY-radius)
//        let cellWidth = self.view.bounds.midX/2.5
        
        // main circles
        backgroundCircle = UIView(frame:CGRect(x: point.x, y: point.y, width: radius, height: radius))
        backgroundCircle!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        backgroundCircle!.layer.cornerRadius = (backgroundCircle?.frame.width)!/2
        backgroundCircle!.clipsToBounds = true
        self.view.addSubview(backgroundCircle!)
        foregroundCircle = UIView(frame: CGRect(x: point.x + 5/2, y: point.y + 5/2, width: radius-5, height: radius-5))
        foregroundCircle!.backgroundColor = .white
        foregroundCircle!.layer.cornerRadius = (foregroundCircle?.frame.width)!/2
        foregroundCircle!.clipsToBounds = true
        self.view.addSubview(foregroundCircle!)
        
        // ventilation button
        ventilationButton = UIButton(frame: CGRect(x: 3/2*point.x, y: point.y + radius/6, width: 2*radius/3, height: 2*radius/3))
        if currentRoom?.wind == "0" {
            ventilationButton!.layer.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            ventilationButton?.titleLabel?.tintColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
            ventilationButton!.tintColor = .white
        } else {
            ventilationButton!.layer.backgroundColor = UIColor(red: 0.933, green: 0.964, blue: 1, alpha: 1).cgColor
            ventilationButton?.titleLabel?.tintColor = .white
            ventilationButton!.tintColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        }
        ventilationButton?.layer.cornerRadius = (ventilationButton?.frame.height)!/2
        ventilationButton?.setTitle("Проветрить", for: .normal)
        ventilationButton?.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(ventilationButton!)
        
        // temperature circle
        temperatureBackgroud = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX - point.x/2, y: point.y - point.x/2 - 10, width: point.x, height: point.x))
        temperatureBackgroud!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        temperatureBackgroud!.layer.cornerRadius = (temperatureBackgroud?.frame.width)!/2
        temperatureBackgroud!.clipsToBounds = true
        self.view.addSubview(temperatureBackgroud!)
        temperatureForeground = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX - point.x/2 + 5/2, y: point.y - point.x/2 + 5/2 - 10, width: point.x-5, height: point.x-5))
        temperatureForeground!.backgroundColor = .white
        temperatureForeground!.layer.cornerRadius = (temperatureForeground?.frame.width)!/2
        temperatureForeground!.clipsToBounds = true
        self.view.addSubview(temperatureForeground!)
        
        tempretureLable = UILabel(frame: temperatureForeground!.frame)
        tempretureLable?.text = currentRoom?.temp
        tempretureLable?.textColor = .black
        tempretureLable?.font = UIFont(name: "Inter-SemiBold", size: 16)
        tempretureLable?.center = CGPoint(x: temperatureForeground!.frame.midX, y: temperatureForeground!.frame.midY)
        tempretureLable?.textAlignment = .center
        self.view.addSubview(tempretureLable!)
        
        // humidity circle
        humidityBackgroud = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX - radius/2 * 0.66 - point.x, y: point.y + radius/4 * 0.7 - 10, width: point.x, height: point.x))
        humidityBackgroud!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        humidityBackgroud!.layer.cornerRadius = (humidityBackgroud?.frame.width)!/2
        humidityBackgroud!.clipsToBounds = true
        self.view.addSubview(humidityBackgroud!)
        humidityForeground = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX - radius/2 * 0.66 - point.x + 5/2, y: point.y + radius/4 * 0.7 + 5/2 - 10, width: point.x-5, height: point.x-5))
        humidityForeground!.backgroundColor = .white
        humidityForeground!.layer.cornerRadius = (humidityForeground?.frame.width)!/2
        humidityForeground!.clipsToBounds = true
        self.view.addSubview(humidityForeground!)
        
        
        // people circle
        peopleBackgroud = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.66 , y: point.y + radius/4 * 0.7 - 10, width: point.x, height: point.x))
        peopleBackgroud!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        peopleBackgroud!.layer.cornerRadius = (peopleBackgroud?.frame.width)!/2
        peopleBackgroud!.clipsToBounds = true
        self.view.addSubview(peopleBackgroud!)
        peopleoreground = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.66 + 5/2, y: point.y + radius/4 * 0.7 + 5/2 - 10, width: point.x-5, height: point.x-5))
        peopleoreground!.backgroundColor = .white
        peopleoreground!.layer.cornerRadius = (peopleoreground?.frame.width)!/2
        peopleoreground!.clipsToBounds = true
        self.view.addSubview(peopleoreground!)
        
        // temperature circle 2.0
        temperatureBackgroud2 = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX - radius/2 * 0.6 - point.x/2, y: point.y + radius * 0.8 - 5, width: point.x, height: point.x))
        temperatureBackgroud2!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        temperatureBackgroud2!.layer.cornerRadius = (temperatureBackgroud2?.frame.width)!/2
        temperatureBackgroud2!.clipsToBounds = true
        self.view.addSubview(temperatureBackgroud2!)
        temperatureForeground2 = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX - radius/2 * 0.6 - point.x/2 + 5/2, y: point.y + radius * 0.8 + 5/2 - 5, width: point.x-5, height: point.x-5))
        temperatureForeground2!.backgroundColor = .white
        temperatureForeground2!.layer.cornerRadius = (temperatureForeground2?.frame.width)!/2
        temperatureForeground2!.clipsToBounds = true
        self.view.addSubview(temperatureForeground2!)
        
        // co2 circle
        co2Backgroud2 = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.6 - point.x/2, y: point.y + radius * 0.8 - 5, width: point.x, height: point.x))
        co2Backgroud2!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        co2Backgroud2!.layer.cornerRadius = (co2Backgroud2?.frame.width)!/2
        co2Backgroud2!.clipsToBounds = true
        self.view.addSubview(co2Backgroud2!)
        co2Foreground2 = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.6 - point.x/2 + 5/2, y: point.y + radius * 0.8 + 5/2 - 5, width: point.x-5, height: point.x-5))
        co2Foreground2!.backgroundColor = .white
        co2Foreground2!.layer.cornerRadius = (co2Foreground2?.frame.width)!/2
        co2Foreground2!.clipsToBounds = true
        self.view.addSubview(co2Foreground2!)
    }
    
    @objc func buttonAction (sender: UIButton!) {
        if currentRoom?.wind == "0" {
            currentRoom?.wind = "1"
            ventilationButton!.layer.backgroundColor = UIColor(red: 0.933, green: 0.964, blue: 1, alpha: 1).cgColor
            ventilationButton?.titleLabel?.tintColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
            ventilationButton!.tintColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        } else {
            currentRoom?.wind = "0"
            ventilationButton!.layer.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1).cgColor
            ventilationButton?.titleLabel?.tintColor = .white
            ventilationButton!.tintColor = .white
        }
        updateUI()
        print(currentRoom?.wind)
    }
    
    
}

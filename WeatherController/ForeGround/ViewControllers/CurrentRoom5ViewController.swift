//
//  CurrentRoom5ViewController.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 12.08.2022.
//

import Foundation
import UIKit

class CurrentRoom5ViewController: UIViewController {
    
    //MARK: var-lets
    var currentRoom: RoomStruct?
    
    private var safeArea: UILayoutGuide!
    private var backgroundCircle: UIView?
    private var foregroundCircle: UIView?
    private var ventilationButton: UIButton?
    private var closeButton: UIButton?
    private var titleLable: UILabel?
    private var addTempButton: UIButton?
    private var minusTempButton: UIButton?
    
    private var temperatureBackgroud: UIView?
    private var temperatureForeground: UIView?
    private var tempretureLable: UILabel?
    
    private var humidityBackgroud: UIView?
    private var humidityForeground: UIView?
    private var humidityLable: UILabel?
    
    private var peopleBackgroud: UIView?
    private var peopleForeground: UIView?
    private var peoplelable: UILabel?
    
    private var temperatureBackgroud2: UIView?
    private var temperatureForeground2: UIView?
    private var temperatureLable2: UILabel?
    
    private var co2Backgroud2: UIView?
    private var co2Foreground2: UIView?
    private var co2Lable: UILabel?
    
    private var temperatureStackView: UIStackView?
    private var co2StackView: UIStackView?
    private var peopleStackView: UIStackView?
    private var humidityStackView: UIStackView?
    
    
    //MARK: funcks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        drawCirclesAndButtons()
    }
    
    private func updateUI() {
        tempretureLable?.text = (currentRoom?.temp)! + " C"
        temperatureLable2?.text = (currentRoom?.temp)! + " C"
    }
    
    private func drawCirclesAndButtons() {
        let point = CGPoint(x: self.safeArea.layoutFrame.maxX / 5, y: self.safeArea.layoutFrame.midY -  self.safeArea.layoutFrame.maxX / 3)
        let radius = 3*point.x

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
        
        // close button
        closeButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        closeButton?.setTitleColor(.black, for: .normal)
        closeButton?.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 20)
        closeButton!.setTitle("X", for: .normal)
        closeButton!.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        self.view.addSubview(closeButton!)
        
        // title lable
        titleLable = UILabel(frame: CGRect(x: self.view.bounds.midX/2, y: 10, width: self.view.bounds.midX, height: 50))
        titleLable?.text = currentRoom?.name
        titleLable?.textColor = .black
        titleLable?.textAlignment = .center
        titleLable?.font = UIFont(name: "Inter-SemiBold", size: 20)
        self.view.addSubview(titleLable!)
        
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
        tempretureLable?.text = (currentRoom?.temp)! + " C"
        tempretureLable?.textColor = .black
        tempretureLable?.font = UIFont(name: "Inter-SemiBold", size: 16)
        tempretureLable?.center = CGPoint(x: temperatureForeground!.frame.midX, y: temperatureForeground!.frame.midY)
        tempretureLable?.textAlignment = .center
        self.view.addSubview(tempretureLable!)
        
        // Add, reduce temp buttons
        addTempButton = UIButton(frame: CGRect(x: (temperatureBackgroud?.frame.midX)! - 3*temperatureBackgroud!.frame.width/2, y: (temperatureBackgroud?.frame.midY)! - temperatureBackgroud!.frame.height/1.8, width: (temperatureBackgroud?.frame.width)!, height: (temperatureBackgroud!.frame.height)))
        addTempButton?.setTitleColor(.black, for: .normal)
        addTempButton?.addTarget(self, action: #selector(plusTemp), for: .touchUpInside)
        addTempButton?.setTitle("+", for: .normal)
        addTempButton?.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 30)
        self.view.addSubview(addTempButton!)
        
        minusTempButton = UIButton(frame: CGRect(x: (temperatureBackgroud?.frame.midX)! + temperatureBackgroud!.frame.width/2, y: (temperatureBackgroud?.frame.midY)! - temperatureBackgroud!.frame.height/1.8, width: (temperatureBackgroud?.frame.width)!, height: (temperatureBackgroud!.frame.height)))
        minusTempButton?.setTitleColor(.black, for: .normal)
        minusTempButton?.addTarget(self, action: #selector(minusTemp), for: .touchUpInside)
        minusTempButton?.setTitle("-", for: .normal)
        minusTempButton?.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 30)
        self.view.addSubview(minusTempButton!)
        
        // change lable
        
        let changeLable = UILabel(frame: CGRect(x: self.view.bounds.midX/2, y: (temperatureBackgroud?.frame.minY)! - 50, width: self.view.bounds.midX, height: 50))
        changeLable.text = "Изменить температуру"
        changeLable.textColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        changeLable.textAlignment = .center
        self.view.addSubview(changeLable)
        
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
        
        // humidity stack
        humidityStack()
        
        
        // people circle
        peopleBackgroud = UIView(frame:CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.66 , y: point.y + radius/4 * 0.7 - 10, width: point.x, height: point.x))
        peopleBackgroud!.backgroundColor = UIColor(red: 0.425, green: 0.586, blue: 1, alpha: 1)
        peopleBackgroud!.layer.cornerRadius = (peopleBackgroud?.frame.width)!/2
        peopleBackgroud!.clipsToBounds = true
        self.view.addSubview(peopleBackgroud!)
        peopleForeground = UIView(frame: CGRect(x: self.safeArea.layoutFrame.midX + radius/2 * 0.66 + 5/2, y: point.y + radius/4 * 0.7 + 5/2 - 10, width: point.x-5, height: point.x-5))
        peopleForeground!.backgroundColor = .white
        peopleForeground!.layer.cornerRadius = (peopleForeground?.frame.width)!/2
        peopleForeground!.clipsToBounds = true
        self.view.addSubview(peopleForeground!)
        
        // people stack
        peopleStack()
        
        
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
        
        // temperature stack
        temoeratureStack()
        
        
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
        
        // co2 stack
        co2Stack()
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
    }
    
    @objc func closeView(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    @objc func plusTemp(sender: UIButton!) {
        if var temp = Int((currentRoom?.temp)!) {
            if temp < 30 {
                temp += 1
                currentRoom?.temp = String(temp)
                updateUI()
            }
        }
    }
    
    @objc func minusTemp(sender: UIButton) {
        if var temp = Int((currentRoom?.temp)!) {
            if temp > 16 {
                temp -= 1
                currentRoom?.temp = String(temp)
                updateUI()
            }
        }
    }
    
    private func temoeratureStack() {
        temperatureStackView = UIStackView(frame: temperatureForeground2!.frame)
        
        let temperatureImage = UIImageView(image: UIImage(named: "temperatureDarkBlue"))
        
        temperatureLable2 = UILabel(frame: CGRect(x: 0, y: 0, width: temperatureStackView!.frame.width, height: 13*temperatureStackView!.frame.height/21))
        temperatureLable2?.text = (currentRoom?.temp)! + " C"
        temperatureLable2?.textColor = .black
        temperatureLable2?.textAlignment = .center
        temperatureLable2?.font = UIFont(name: "Inter-SemiBold", size: 14)
        
        let upperStackView = UIStackView(frame: CGRect(x: temperatureStackView!.frame.minX, y: temperatureStackView!.frame.minY, width: temperatureStackView!.frame.width, height: 7*temperatureStackView!.frame.height/21))
        
        let spacerLaber1 = UILabel(frame: CGRect(x: 0, y: 0, width: upperStackView.frame.width/4, height: upperStackView.frame.height))
        spacerLaber1.text = " "
        let spacerLaber2 = UILabel(frame: CGRect(x: 0, y: 0, width: spacerLaber1.frame.width, height: spacerLaber1.frame.height))
        spacerLaber2.text = " "
        let upperSpacer = UILabel(frame: CGRect(x: 0, y: 0, width: temperatureStackView!.frame.width, height: temperatureStackView!.frame.height/21))
        upperSpacer.backgroundColor = .none
        
        upperStackView.axis = NSLayoutConstraint.Axis.horizontal
        upperStackView.distribution = UIStackView.Distribution.fillProportionally
        upperStackView.addArrangedSubview(spacerLaber1)
        upperStackView.addArrangedSubview(temperatureImage)
        upperStackView.addArrangedSubview(spacerLaber2)
        
        temperatureStackView!.axis = NSLayoutConstraint.Axis.vertical
        temperatureStackView!.distribution = .fillProportionally
//        temperatureStackView?.alignment = .center
        temperatureStackView!.addArrangedSubview(upperSpacer)
        temperatureStackView?.setCustomSpacing(5, after: upperSpacer)
        temperatureStackView!.addArrangedSubview(upperStackView)
        temperatureStackView!.addArrangedSubview(temperatureLable2!)
        self.view.addSubview(temperatureStackView!)
    }
    
    private func co2Stack() {
        co2StackView = UIStackView(frame: co2Foreground2!.frame)
        
        let Image = UIImageView(image: UIImage(named: "CO2DarkBlue"))
        
        co2Lable = UILabel(frame: CGRect(x: 0, y: 0, width: co2StackView!.frame.width, height: 13*co2StackView!.frame.height/21))
        co2Lable?.text = (currentRoom?.co2)! + " ppm"
        co2Lable?.textColor = .black
        co2Lable?.textAlignment = .center
        co2Lable?.font = UIFont(name: "Inter-SemiBold", size: 14)
        
        let upperStackView = UIStackView(frame: CGRect(x: co2StackView!.frame.minX, y: co2StackView!.frame.minY, width: co2StackView!.frame.width, height: 7*co2StackView!.frame.height/21))
        
        let spacerLaber1 = UILabel(frame: CGRect(x: 0, y: 0, width: upperStackView.frame.width/4, height: upperStackView.frame.height))
        spacerLaber1.text = " "
        let spacerLaber2 = UILabel(frame: CGRect(x: 0, y: 0, width: spacerLaber1.frame.width, height: spacerLaber1.frame.height))
        spacerLaber2.text = " "
        let upperSpacer = UILabel(frame: CGRect(x: 0, y: 0, width: co2StackView!.frame.width, height: co2StackView!.frame.height/21))
        upperSpacer.backgroundColor = .none
        
        upperStackView.axis = NSLayoutConstraint.Axis.horizontal
        upperStackView.distribution = UIStackView.Distribution.fillProportionally
        upperStackView.addArrangedSubview(spacerLaber1)
        upperStackView.addArrangedSubview(Image)
        upperStackView.addArrangedSubview(spacerLaber2)
        
        co2StackView!.axis = NSLayoutConstraint.Axis.vertical
        co2StackView!.distribution = .fillProportionally
        co2StackView!.addArrangedSubview(upperSpacer)
        co2StackView?.setCustomSpacing(5, after: upperSpacer)
        co2StackView!.addArrangedSubview(upperStackView)
        co2StackView!.addArrangedSubview(co2Lable!)
        self.view.addSubview(co2StackView!)
    }
    
    private func peopleStack() {
        peopleStackView = UIStackView(frame: peopleForeground!.frame)
        
        let Image = UIImageView(image: UIImage(named: "peopleDarkBlue"))
        
        peoplelable = UILabel(frame: CGRect(x: 0, y: 0, width: peopleStackView!.frame.width, height: 13*peopleStackView!.frame.height/21))
        peoplelable?.text = (currentRoom?.people)! + " чел"
        peoplelable?.textColor = .black
        peoplelable?.textAlignment = .center
        peoplelable?.font = UIFont(name: "Inter-SemiBold", size: 14)
        
        let upperStackView = UIStackView(frame: CGRect(x: peopleStackView!.frame.minX, y: peopleStackView!.frame.minY, width: peopleStackView!.frame.width, height: 7*peopleStackView!.frame.height/21))
        
        let spacerLaber1 = UILabel(frame: CGRect(x: 0, y: 0, width: upperStackView.frame.width/4, height: upperStackView.frame.height))
        spacerLaber1.text = " "
        let spacerLaber2 = UILabel(frame: CGRect(x: 0, y: 0, width: spacerLaber1.frame.width, height: spacerLaber1.frame.height))
        spacerLaber2.text = " "
        let upperSpacer = UILabel(frame: CGRect(x: 0, y: 0, width: peopleStackView!.frame.width, height: peopleStackView!.frame.height/21))
        upperSpacer.backgroundColor = .none
        
        upperStackView.axis = NSLayoutConstraint.Axis.horizontal
        upperStackView.distribution = UIStackView.Distribution.fillProportionally
        upperStackView.addArrangedSubview(spacerLaber1)
        upperStackView.addArrangedSubview(Image)
        upperStackView.addArrangedSubview(spacerLaber2)
        
        peopleStackView!.axis = NSLayoutConstraint.Axis.vertical
        peopleStackView!.distribution = .fillProportionally
        peopleStackView!.addArrangedSubview(upperSpacer)
        peopleStackView?.setCustomSpacing(5, after: upperSpacer)
        peopleStackView!.addArrangedSubview(upperStackView)
        peopleStackView!.addArrangedSubview(peoplelable!)
        self.view.addSubview(peopleStackView!)
    }
    
    private func humidityStack() {
        humidityStackView = UIStackView(frame: humidityForeground!.frame)
        
        let Image = UIImageView(image: UIImage(named: "humidityDarkBlue"))
        
        humidityLable = UILabel(frame: CGRect(x: 0, y: 0, width: humidityStackView!.frame.width, height: 13*humidityStackView!.frame.height/21))
        humidityLable?.text = (currentRoom?.hum)! + "%"
        humidityLable?.textColor = .black
        humidityLable?.textAlignment = .center
        humidityLable?.font = UIFont(name: "Inter-SemiBold", size: 14)
        
        let upperStackView = UIStackView(frame: CGRect(x: humidityStackView!.frame.minX, y: humidityStackView!.frame.minY, width: humidityStackView!.frame.width, height: 7*humidityStackView!.frame.height/21))
        
        let spacerLaber1 = UILabel(frame: CGRect(x: 0, y: 0, width: upperStackView.frame.width/4, height: upperStackView.frame.height))
        spacerLaber1.text = " "
        let spacerLaber2 = UILabel(frame: CGRect(x: 0, y: 0, width: spacerLaber1.frame.width, height: spacerLaber1.frame.height))
        spacerLaber2.text = " "
        let upperSpacer = UILabel(frame: CGRect(x: 0, y: 0, width: humidityStackView!.frame.width, height: humidityStackView!.frame.height/21))
        upperSpacer.backgroundColor = .none
        
        upperStackView.axis = NSLayoutConstraint.Axis.horizontal
        upperStackView.distribution = UIStackView.Distribution.fillProportionally
        upperStackView.addArrangedSubview(spacerLaber1)
        upperStackView.addArrangedSubview(Image)
        upperStackView.addArrangedSubview(spacerLaber2)
        
        humidityStackView!.axis = NSLayoutConstraint.Axis.vertical
        humidityStackView!.distribution = .fillProportionally
        humidityStackView!.addArrangedSubview(upperSpacer)
        humidityStackView?.setCustomSpacing(5, after: upperSpacer)
        humidityStackView!.addArrangedSubview(upperStackView)
        humidityStackView!.addArrangedSubview(humidityLable!)
        self.view.addSubview(humidityStackView!)
    }
}

//
//  CustomStackViewCell.swift
//  WeatherController
//
//  Created by Mikhail Chibrin on 14.08.2022.
//

import UIKit

class CustomStackViewCell: UIStackView {
    
    let point: CGPoint? = CGPoint(x: 0, y: 0)
    var customHorisontalStackView1: UIStackView?
    var customHorisontalStackView2: UIStackView?
    var image: UIImageView?
    var textLable: UILabel?
    
    override func draw(_ rect: CGRect) {
        self.axis = NSLayoutConstraint.Axis.vertical
        self.distribution = UIStackView.Distribution.fillProportionally
        
    }
    
    func stackDraw(imageName: String, text: String) {
        let highLable = UILabel(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: point!.x, height: 10))
        let lowLable = UILabel(frame: CGRect(x: self.frame.minX, y: self.frame.maxY - 10, width: point!.x, height: 10))
        customHorisontalStackView1 = UIStackView(frame: CGRect(x: self.frame.minX, y: self.frame.minY + 10, width: point!.x, height: 30))
        let leftLable = UILabel(frame: CGRect(x: customHorisontalStackView1!.frame.minX, y: customHorisontalStackView1!.frame.minY, width: (customHorisontalStackView1!.frame.width - 30) / 2 , height: 30))
        let rightLable = UILabel(frame: CGRect(x: customHorisontalStackView1!.frame.maxX - point!.x/10, y: customHorisontalStackView1!.frame.minY, width: (customHorisontalStackView1!.frame.width - 30) / 2, height: 30))
        image = UIImageView(frame: CGRect(x: customHorisontalStackView1!.frame.minX + (customHorisontalStackView1!.frame.width - 30) / 2, y: customHorisontalStackView1!.frame.minY, width: 30 , height: 30))
        image?.image = UIImage(named: imageName)
        customHorisontalStackView1?.addSubview(leftLable)
        customHorisontalStackView1?.addSubview(image!)
        customHorisontalStackView1?.addSubview(rightLable)
        
        textLable = UILabel(frame: CGRect(x: self.frame.minX, y: self.frame.minY + 40, width: point!.x, height: self.frame.maxY - 50))
        textLable?.textColor = .black
        textLable?.textAlignment = .center
        textLable?.font = UIFont(name: "Inter-SemiBold", size: 10)
        textLable?.text = text
        
        self.addSubview(highLable)
        self.addSubview(customHorisontalStackView1!)
        self.addSubview(textLable!)
        self.addSubview(lowLable)
    }
}

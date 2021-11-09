//
//  UILabel.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 28.10.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, color: UIColor?, aligment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

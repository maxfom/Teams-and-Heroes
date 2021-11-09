//
//  UITextField.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 27.10.2021.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String, keyboardType: UIKeyboardType?, font: UIFont?) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.keyboardType = keyboardType ?? .default
        self.returnKeyType = UIReturnKeyType.done
        self.autocorrectionType = UITextAutocorrectionType.no
        self.font = font
        self.borderStyle = UITextField.BorderStyle.roundedRect
        self.clearButtonMode = UITextField.ViewMode.whileEditing;
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
}

//
//  UIFont.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 27.10.2021.
//

import UIKit

extension UIFont {
    
    enum robotoWeight {
        case light
        case regular
        case medium
    }
    
    
    static func robotoFont(ofSize size: CGFloat, weight: robotoWeight) -> UIFont? {
        
        switch weight {
        case .light:
            return UIFont.init(name: "Roboto-Light", size: size)
        case .regular:
            return UIFont.init(name: "Roboto-Regular", size: size)
        case .medium:
            return UIFont.init(name: "Roboto-Medium", size: size)
        }
    }
}

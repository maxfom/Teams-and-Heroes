//
//  UIButton + Extension.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 02.11.2021.
//

import UIKit

extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }

    // Add touch area
    fileprivate struct UIButtonAssociatedKeys {
        static var addedTouchArea: CGFloat = 0
    }

    var addedTouchArea: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &UIButtonAssociatedKeys.addedTouchArea) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &UIButtonAssociatedKeys.addedTouchArea, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }

    open override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let area = self.bounds.insetBy(dx: -(addedTouchArea ?? 0), dy: -(addedTouchArea ?? 0))
        return area.contains(point)
    }
}

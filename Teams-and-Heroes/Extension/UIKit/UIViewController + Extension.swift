//
//  UIViewController + Extension.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 05.11.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

//
//  AlertOk.swift
//  MySchedule
//
//  Created by Максим Фомичев on 16.10.2021.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String?, completion: @escaping () -> Void = { }) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
        
    }
}

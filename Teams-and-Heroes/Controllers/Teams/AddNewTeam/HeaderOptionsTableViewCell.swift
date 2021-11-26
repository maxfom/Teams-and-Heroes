//
//  HeaderOptionsTableViewCell.swift
//  MySchedule
//
//  Created by Максим Фомичев on 01.10.2021.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {

    let headerLabel = UILabel(text: "", font: .robotoFont(ofSize: 14, weight: .medium), color: UIColor().colorFromHex("#444444"))
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
        
    }
    
}


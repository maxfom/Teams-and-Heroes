//
//  AddNewHeroTableViewCell.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 30.11.2021.
//

import UIKit

final class AddNewHeroTableViewCell: UITableViewCell {
    
    let nameCellLabel = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .none
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellHeroImageConfigure(cellNameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section]
        indexPath.section == 3 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
    }
    
    private func setupConstraints() {
        self.addSubview(nameCellLabel)
        self.addSubview(backgroundViewCell)
        
        nameCellLabel.snp.makeConstraints { name in
            name.top.equalTo(self.snp.top).offset(11)
            name.bottom.equalTo(self.snp.bottom).offset(-11)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
        }
        
        backgroundViewCell.snp.makeConstraints { make in
            make.top.equalTo(self).offset(0)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalTo(self).offset(0)
        }
    }
}

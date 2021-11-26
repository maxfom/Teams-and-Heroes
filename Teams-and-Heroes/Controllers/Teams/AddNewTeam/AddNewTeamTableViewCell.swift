//
//  AddNewTeamTableViewCell.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 14.11.2021.
//

import UIKit

final class AddNewTeamTableViewCell: UITableViewCell {
    
    let nameCellLabel = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
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
    
    func configure(cellNameArray: [String], indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section]
    }
    
    private func setupConstraints() {
        self.addSubview(nameCellLabel)
        //self.addSubview(backgroundViewCell)
        
        nameCellLabel.snp.makeConstraints { name in
            name.top.equalTo(self.snp.top).offset(11)
            name.bottom.equalTo(self.snp.bottom).offset(-11)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
            //name.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
        }
        
//        backgroundViewCell.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top).offset(5)
//            make.left.equalToSuperview().offset(36)
//            make.right.equalToSuperview().inset(15)
//            make.height.equalTo(150)
//        }
    }
}

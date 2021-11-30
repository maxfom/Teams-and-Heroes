//
//  ChooseHeroTableViewCell.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 01.12.2021.
//

import UIKit

final class ChooseHeroTableViewCell: UITableViewCell {
    
    private let heroName = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))
    
    private let speakText = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with heroes: [Hero], index: Int) {
        heroName.text = heroes[index].name
        speakText.text = heroes[index].speak
        heroName.numberOfLines = 0
        heroName.sizeToFit()
    }
    
    private func setupConstraints() {
        addSubview(heroName)
        addSubview(speakText)
        
        heroName.snp.makeConstraints { name in
            name.top.equalTo(self.snp.top).offset(5)
            //name.bottom.equalTo(self.snp.bottom).inset(-25)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
            //name.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
        }
        
        speakText.snp.makeConstraints { name in
            name.top.equalTo(heroName).offset(24)
            name.bottom.equalTo(self.snp.bottom).inset(5)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
            //name.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
        }
    }
}

//
//  MainTeamsTableViewCell.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 14.11.2021.
//

import UIKit

final class MainTeamsTableViewCell: UITableViewCell {
    
    private let teamTitle = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))
    
    private let leaderName = UILabel(text: "Label", font: .robotoFont(ofSize: 16, weight: .regular), color: UIColor().colorFromHex("#747474"))

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with teams: [Teams], index: Int) {
        teamTitle.text = teams[index].name
        leaderName.text = teams[index].leader
        teamTitle.numberOfLines = 0
        teamTitle.sizeToFit()
    }
    
    private func setupConstraints() {
        addSubview(teamTitle)
        addSubview(leaderName)
        
        teamTitle.snp.makeConstraints { name in
            name.top.equalTo(self.snp.top).offset(5)
            //name.bottom.equalTo(self.snp.bottom).inset(-25)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
            //name.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
        }
        
        leaderName.snp.makeConstraints { name in
            name.top.equalTo(teamTitle).offset(24)
            name.bottom.equalTo(self.snp.bottom).inset(5)
            name.left.equalToSuperview().offset(36)
            name.right.equalToSuperview().inset(15)
            //name.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
        }
    }
}

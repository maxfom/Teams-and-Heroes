//
//  UserModel.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation

struct SearchFiltersModel: Codable {
    
    let filter: String
    let icon: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case filter
        case icon
        case title
    }
}

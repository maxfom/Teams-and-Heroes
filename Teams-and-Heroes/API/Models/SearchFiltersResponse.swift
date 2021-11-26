//
//  UserRespornse.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation

struct SearchFiltersResponse: Codable {
    
    let filters: [filters]?
    
    struct filters: Codable {
        let filter: String
        let icon: String
        let title: String
    }
    
}

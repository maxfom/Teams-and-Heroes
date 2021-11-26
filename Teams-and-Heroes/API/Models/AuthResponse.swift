//
//  AuthResponse.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation

struct AuthResponse: Codable {
    let data: SearchFiltersModel?
    let message: String?
}

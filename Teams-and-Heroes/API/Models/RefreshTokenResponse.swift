//
//  RefreshTokenResponse.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 02.11.2021.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let error: String?
    let userID: String?
    let token: String?
    let refreshToken: String?
}

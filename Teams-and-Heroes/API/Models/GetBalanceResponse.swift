//
//  GetBalanceResponse.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 02.11.2021.
//

import Foundation

struct GetBalanceResponse: Codable {
    let error: Error?
    let balance: String?
    
    enum Error: String, Codable {
        case needRefresh = "need_refresh"
    }
    
    enum CodingKeys: String, CodingKey {
        case balance = "balance"
        case error = "error"
    }
}

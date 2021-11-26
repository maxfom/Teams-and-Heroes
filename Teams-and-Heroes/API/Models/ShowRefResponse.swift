//
//  ShowRefResponse.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 03.11.2021.
//

import Foundation

struct ShowRefResponse: Codable {
    let error: Error?
    let siteURL: String?
    let id: Int?
    let favoriteId: String?
    let langCode: String?
    let title: String?
    let fiftyTxt: String?
    let canBuyFulltxt: Int?
    let aLike: [aLike]?
    let asPic: [asPic]?

    enum Error: String, Codable {
        case needRefresh = "need_refresh"
    }

    enum CodingKeys: String, CodingKey {
        case error
        case siteURL
        case id = "ID"
        case favoriteId = "favoriteID"
        case langCode
        case title
        case fiftyTxt
        case canBuyFulltxt
        case aLike
        case asPic
    }

    struct aLike: Codable {
        let likeId: Int
        let title: String

        enum CodingKeys: String, CodingKey {
            case likeId = "likeID"
            case title
        }
    }

    struct asPic: Codable {
        let src: String
    }
}

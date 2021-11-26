//
//  FavouritesRefsResponse.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 08.11.2021.
//

import Foundation

struct FavouritesRefsResponse: Codable {
    let error: Error?
    let favList: [FavList]?

    enum Error: String, Codable {
        case needRefresh = "need_refresh"
    }

    struct FavList: Codable {
        let favoriteID: String?
        let title: String?
        let langCode: String?
        let linkApi: String?

        enum CodingKeys: String, CodingKey {
            case favoriteID = "favoriteID"
            case title = "title"
            case langCode = "langCode"
            case linkApi = "linkAPI"
        }
    }
}

struct AddFavoriteResponse: Codable {
    let ok: Int?
}

struct DelFavoriteResponse: Codable {
    let ok: Int?
}

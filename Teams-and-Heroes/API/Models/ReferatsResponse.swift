//
//  ReferatsResponse.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 02.11.2021.
//

import Foundation

struct ReferatsResponse: Codable {
    let error: Error?
    let workType: String?
    let searchType: String?
    let searchStr: String?
    let filterShow: Bool?
    let searchRes: [SearchRes]?

    enum Error: String, Codable {
        case needRefresh = "need_refresh"
    }

    struct SearchRes: Codable {
        let id: Int
        let title: String
        let langCode: String
        let linkApi: String

        enum CodingKeys: String, CodingKey {
            case id = "ID"
            case title
            case langCode
            case linkApi = "linkAPI"
        }
    }
}

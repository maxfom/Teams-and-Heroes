//
//  RefAPI.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation

private struct EndPoints {
    static let login = "loginGoogle"
    static let search = "search"
    static let searchFilters = "ru/searchfilters"
    static let listFavorite = "listFavorite"
    static let addFavorite = "addFavorite/1-"
    static let deleteFavorite = "deleteFavorite/1-"
    static let getPDFPages = "getPDFpages"
}

class RefAPI {
    static func getFiltersRefs(completion: @escaping (Swift.Result<SearchFiltersResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedGetRequest(endPoint: EndPoints.searchFilters, parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func searchRefs(searchText: String, completion: @escaping (Swift.Result<ReferatsResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: "\(EndPoints.search)/\(searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)", parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func filterSearchedRefs(searchText: String, filter: String, completion: @escaping (Swift.Result<ReferatsResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: "\(EndPoints.search)/\(filter)/\(searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)", parameters: nil, success: { data in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }

    static func showRef(linkApi: String, completion: @escaping (Swift.Result<ShowRefResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: String(linkApi.dropFirst()), parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }

    static func getFavouriteRefs(completion: @escaping (Swift.Result<FavouritesRefsResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: EndPoints.listFavorite, parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func addRefToFavorite(refID: String, completion: @escaping (Swift.Result<AddFavoriteResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: "\(EndPoints.addFavorite)\(refID)", parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func deleteRefFromFavorite(refID: String, completion: @escaping (Swift.Result<DelFavoriteResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: "\(EndPoints.deleteFavorite)\(refID)", parameters: nil, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func getPDFPages(refID: String, ImageLinks: String, completion: @escaping (Swift.Result<PDFPagesResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: EndPoints.getPDFPages,
                                        parameters: [
                                            "favoriteID" : "1-\(refID)", // ID реферата
                                            "images" : ImageLinks, // Названия картинок
                                        ],
                                      success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    //getPDFpages
}

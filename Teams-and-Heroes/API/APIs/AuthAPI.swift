//
//  AuthAPI.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation

private struct EndPoints {
    static let loginGoogle = "loginFirebase"
    static let runTokenRefresh = "runTokenRefresh"
    static let getBalance = "getBalance"
}

class AuthAPI {
    
    static func autorize(request: AuthRequest, completion: @escaping (Swift.Result<RefreshTokenResponse, NetworkError>) -> Void) {
        BaseAPI.unAuthorizedPostRequest(endPoint: EndPoints.loginGoogle, parameters: request.dictionary, success: { (data) in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }

    static func refreshToken(request: TokenRefreshRequest, completion: @escaping (Swift.Result<RefreshTokenResponse, NetworkError>) -> Void) {
        BaseAPI.unAuthorizedPostRequest(endPoint: EndPoints.runTokenRefresh, parameters: request.dictionary) { data in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        } failure: { error in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }

    static func getBalance(completion: @escaping (Swift.Result<GetBalanceResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(endPoint: EndPoints.getBalance, parameters: nil) { data in
            if let data = data {
                RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
            } else {
                completion(.failure(NetworkError(.server)))
            }
        } failure: { error in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
}

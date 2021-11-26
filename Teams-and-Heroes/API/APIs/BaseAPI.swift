//
//  BaseAPI.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 02.11.2021.
//

import Foundation
import Alamofire

class BaseAPI {
    
    static let domainURL: String = "https://app.studkz.com"
    static let baseURL: String = "\(domainURL)/"
    static let authorizedSession = Session(interceptor: RequestInterceptor())
    
    let headers: HTTPHeaders = {
        var headers = ["Accept": "application/json"]
        return HTTPHeaders(headers)
    }()
    
    private static func request(method: HTTPMethod, endPoint: String, parameters: [String: Any]?, isAuthorized: Bool, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        var parameters = parameters
        if isAuthorized {
            if parameters == nil {
                parameters = [String: Any]()
            }
        }
        let headers = BaseAPI().headers

        authorizedSession.request("\(BaseAPI.baseURL)\(endPoint)",
                                  method: method,
                                  parameters: parameters,
                                  encoding: URLEncoding.default,
                                  headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print("JSON Status: \(String(describing: response.response?.statusCode)), Response:", response)
                guard response.data?.base64EncodedString() != "need_refresh" else {
                       print("looooool")
                    return
                       }
                guard response.response?.statusCode != 429 else {
                    let error = NetworkError(.other("Слишком много запросов"), code: response.response?.statusCode)
                    failure(error)
                    return
                }
                
                guard response.response?.statusCode != 500, response.response?.statusCode != 405 else {
                    failure(NetworkError(.server, code: response.response?.statusCode))
                    return
                }
                
                guard response.response?.statusCode != -1001 else {
                    let error = NetworkError(.other("Превышено время ожидания"), code: -1001)
                    failure(error)
                    return
                }
                
                guard response.response?.statusCode != 403 else {
                    let error = NetworkError(.other("Ошибка авторизации"), code: 403)
                    failure(error)
                    return
                }
                
                guard response.response?.statusCode != 404 else {
                    let error = NetworkError(.other("Ошибка 404"), code: 404)
                    failure(error)
                    return
                }
                
                guard response.response?.statusCode != 503 else {
                    let error = NetworkError(.other("Сервис временно недоступен, попробуйте повторить запрос позже"), code: 503)
                    failure(error)
                    return
                }
                
                if let data = response.data {
                    success(data)
                } else {
                    failure(NetworkError(.server, code: response.response?.statusCode))
                }
            }
    }
    
    static func unAuthorizedPostRequest(endPoint: String, parameters: [String: Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .post, endPoint: endPoint, parameters: parameters, isAuthorized: false, success: success, failure: failure)
    }
    
    static func unAuthorizedGetRequest(endPoint: String, parameters: [String: Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .get, endPoint: endPoint, parameters: parameters, isAuthorized: false, success: success, failure: failure)
    }
    
    static func authorizedGetRequest(endPoint: String, parameters: [String: Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .get, endPoint: endPoint, parameters: parameters, isAuthorized: true, success: success, failure: failure)
    }

    static func authorizedPostRequest(endPoint: String, parameters: [String: Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .post, endPoint: endPoint, parameters: parameters, isAuthorized: true, success: success, failure: failure)
    }
    
    static func authorizedDeleteRequest(endPoint: String, parameters: [String: Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .delete, endPoint: endPoint, parameters: parameters, isAuthorized: true, success: success, failure: failure)
    }
    
    static func searchBaseRequest(searchID: String, endPoint: String, parameters: [String : Any]?, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(method: .get, endPoint: endPoint, parameters: parameters, isAuthorized: true, success: success, failure: failure)
    }
}

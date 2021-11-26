//
//  PayAPI.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 09.11.2021.
//

import Foundation

private struct EndPoints {
    static let pay = "cloudPay"
    static let post3ds = "post3ds"
}

class PayAPI {
    
    static func charge(cardCryptogramPacket: String, amount: Int, completion: @escaping (Swift.Result<TransactionResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(
            endPoint: "\(EndPoints.pay)",
            parameters: [
                "amount" : "\(amount)", // Сумма платежа (Обязательный)
                "currency" : "KZT", // Валюта (Обязательный)
                "card_cryptogram_packet" : cardCryptogramPacket, // Криптограмма платежных данных (Обязательный)
                "CultureName" : "ru-RU",
            ],
            success: { (data) in
                if let data = data {
                    RequestDecoder.decode(data: data, parseFromRootKey: "", completion: completion)
                } else {
                    completion(.failure(NetworkError(.server)))
                }
            }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
    static func post3ds(transactionId: String, paRes: String, completion: @escaping (Swift.Result<TransactionResponse, NetworkError>) -> Void) {
        BaseAPI.authorizedPostRequest(
            endPoint: "\(EndPoints.post3ds)",
            parameters: [
                "transaction_id" : transactionId,
                "pa_res" : paRes,
            ],
            success: { (data) in
                if let data = data {
                    RequestDecoder.decode(data: data, completion: completion)
                    print(data)
                } else {
                    completion(.failure(NetworkError(.server)))
                }
            }) { (error) in
            completion(.failure(error ?? NetworkError(.server)))
        }
    }
    
            
//            let request = HTTPRequest(resource: .post3ds, method: .post, parameters: parameters)
//            makeObjectRequest(request, completion: completion)
//        }
//    }
    
    
}

//
//  TransactionResponse.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 09.11.2021.
//

import Foundation

struct TransactionResponse: Codable {
    
    let success: Bool?
    let message: String?
    let model: Model?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case success = "Success"
        case model = "Model"
    }
    
    struct Model: Codable {
        let transactionId: Int?
        let reasonCode: Int?
        let paReq: String?
        let acsUrl: String?
        let cardHolderMessage: String?
        
        enum CodingKeys: String, CodingKey {
            case transactionId = "TransactionId"
            case reasonCode = "ReasonCode"
            case paReq = "PaReq"
            case acsUrl = "AcsUrl"
            case cardHolderMessage = "CardHolderMessage"
        }
    }
}


//Модель ответа
//{
//    "Model": {
//        "TransactionId": 912825847,
//        "PaReq": "e5f2e7bb7def4629a42a3e615076dfd7@912825847",
//        "GoReq": null,
//        "AcsUrl": "https://api.cloudpayments.ru/payment/acs?912825847",
//        "ThreeDsSessionData": null,
//        "IFrameIsAllowed": true,
//        "FrameWidth": null,
//        "FrameHeight": null,
//        "ThreeDsCallbackId": "e5f2e7bb7def4629a42a3e615076dfd7",
//        "EscrowAccumulationId": null
//    },
//    "Success": false,
//    "Message": null
//}

//
//  PDFPagesResponse.swift
//  Stud.kz
//
//  Created by Максим Фомичев on 12.11.2021.
//

import Foundation

struct PDFPagesResponse: Codable {
    
    //let error: Error?
    let status: String?
    let sum: Int?
    let message: String?
    
//    enum Error: String, Codable {
//        case needRefresh = "need_refresh"
//        case needPay = "need_pay"
//    }
    
//    enum Status: String, Codable {
//        case need_pay = "need_pay"
//        case need
//    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sum = "sum"
        case message = "message"
        //case error
    }
}


//"status": "need_pay",
//"sum": 70,
//"message": "Бұл беттерді PDF түрінде жүктеп алу үшін cізге төлем жасау қажет: 70 теңге"

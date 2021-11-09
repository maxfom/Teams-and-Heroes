//
//  String.swift
//  Stud.kz
//
//  Created by Руслан Садыков on 03.11.2021.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

//extension String {
//    func aesDecrypt(key: String, iv: String) throws -> String {
//        let data = self.data(using: String.Encoding.utf8)
//        let dec = try AES(key: key, iv: iv).decrypt(data!.bytes)
//        let decData = NSData(bytes: dec, length: Int(dec.count)) as Data
//        let result = NSString(data: decData, encoding: String.Encoding.utf8.rawValue)
//        return String(result!)
//    }
//}

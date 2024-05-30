//
// Created by Larry on 2020/2/11.
// Copyright (c) 2020 tikes. All rights reserved.
//

import Foundation
import CryptoSwift

public func EncodeAesEcb(strToEncode: String) -> String {
//    let key = "keykeykeykeykeyk"
    let key = "~FF)]f+PDxP/OsG^"
    
    let data = strToEncode.data(using: String.Encoding.utf8)
     
    
    do {
       // encrypted = try AES(key: key, iv: iv).encrypt(data!.bytes)
        let ivBytes = key.data(using: String.Encoding.utf8)
        let keyBytes = Array(key.data(using: String.Encoding.utf8)!)
        let aes = try AES(key: keyBytes, blockMode: CBC(iv: Array(ivBytes!)), padding: .pkcs5) // aes128
        //let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
        if data == nil {
            return ""
        }
        let ciphertext = try aes.encrypt(Array(data!))
        

        let aa = Data(ciphertext).toHexString().uppercased()
        
        print("hahhaha \(aa)")
        return aa
    } catch  let err {
        print("error:\(err)")//捕捉到错误，处理错误
    }
    return ""
}

//
//  chat.swift
//  case
//
//  Created by Larry on 2020/2/12.
//  Copyright © 2020 tikes. All rights reserved.
//

import Foundation


func sendSayRequest(Fun: @escaping (Slave_SayReply?, Error?) -> Void) -> Int {

    do {

        let userId = 61482
        let str = "\(userId)_193_1"
        let auth = EncodeAesEcb(strToEncode: str)


        var info = Slave_SayRequest()
        info.msg = "hello"
        info.toID = 10010879

        let binaryData: Data = try info.serializedData()

        print("结果是 \(binaryData.toHexString()) ")
        let apiUri = "http://localhost:7410/Say"

        //let url = URL(string: "http://localhost:7500/chat/say")
        let url = URL(string: apiUri)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = binaryData
        request.addValue(auth, forHTTPHeaderField: "Auth")

        let task = URLSession.shared.dataTask(with: request) { data, resp, err in
            guard err == nil && data != nil  else {
                print(err?.localizedDescription ?? "No data")
                Fun(nil, err)
                return
            }
            guard let httpResp = resp as? HTTPURLResponse else {
                print("响应结果类型有误")
                Fun(nil, nil)
                return
            }
            
//            if let httpResponse = response as? NSHTTPURLResponse {
//                print("Status code: (\(httpResponse.statusCode))")
//
//                // do stuff.
//            }
            
            
            let hexResp = data?.toHexString()
            print("resp hex \(hexResp!),状态码是 \(httpResp.statusCode)")
            
            var reply = Slave_SayReply()
            
            do {
                 try reply.merge(serializedData: data!)

                Fun(reply, nil)
            } catch let err {
                print("序列化出错 \(err)")
            }
            
            let strResp = String(decoding: data!, as: UTF8.self)
            print("resp str \(strResp)")
        }
        task.resume()

    } catch let err {
        print("序列化出错 \(err)")
    }

    return 0
}

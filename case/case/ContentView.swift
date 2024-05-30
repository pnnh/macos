//
//  ContentView.swift
//  case
//
//  Created by Larry on 2020/2/11.
//  Copyright © 2020 tikes. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        Button(action: {
            //self.sendText()

            self.serializeProtobuf()
        }) {
            Text("发文字消息")
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func serializeProtobuf() {

        do {

            let userId = 61482
            let str = "\(userId)_23_1"
            let auth = EncodeAesEcb(strToEncode: str)


            var info = Slave_SayRequest()
            info.msg = "hello"
            info.toID = 10010879

            let binaryData: Data = try info.serializedData()

            print("结果是 \(binaryData.toHexString()) ")

            let url = URL(string: "https://abc.test.com:7410/Say")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = binaryData
            request.addValue(auth, forHTTPHeaderField: "Auth")

            let task = URLSession.shared.dataTask(with: request) { data, resp, err in
                guard err == nil else {
                    print(err?.localizedDescription ?? "No data")
                    return
                }
                let hexResp = data?.toHexString()
                print("resp hex \(hexResp!)")

                let strResp = String(decoding: data!, as: UTF8.self)

                print("resp str \(strResp)")
            }
            task.resume()

        } catch let err {
            print("序列化出错 \(err)")
        }


    }


    func sendText() {
        print("dddd")
        let userId = 61482
        let str = "\(userId)_23_1"

        let a = EncodeAesEcb(strToEncode: str)

        print("aaajjj \(a)")

//        HTTP.GET("https://baidu.com") { response in
//            if let err = response.error {
//                print("error: \(err.localizedDescription)")
//                return //also notify app of failure as needed
//            }
//            //print("opt finished: \(response.description)")
//            //print("data is: \(response.data)") access the response of the data with response.data
//        }
        
       let url = URL(string: "https://baidu.com")
       var request = URLRequest(url: url!)
       request.httpMethod = "GET"

       let task = URLSession.shared.dataTask(with: request) { data, resp, err in
           guard err == nil else {
               print(err?.localizedDescription ?? "No data")
               return
           }
           let hexResp = data?.toHexString()
           print("resp hex \(hexResp!)")

           let strResp = String(decoding: data!, as: UTF8.self)

           print("resp str \(strResp)")
    
       }
       task.resume()
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

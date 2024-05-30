//
//  ViewController.swift
//  case
//
//  Created by Larry on 2020/2/12.
//  Copyright © 2020 tikes. All rights reserved.
//
import Foundation
import AppKit
import KituraWebSocketClient

class ViewController: NSViewController {
 
    @IBAction func ssss(_ sender: Any) {
        let pass = generateRandomString(length: 8)
        print("随机密码是 \(pass)")
    }
    @IBOutlet weak var stack2: NSStackView!
    @IBOutlet weak var btnEm: NSButton!
    @IBOutlet weak var labConn: NSTextField!
    
    @IBAction func doSay(_ sender: Any) {
        print("doConnect")
       
        sendSayRequest(){ reply, err in
            print("jjjj222 \(reply) 错误\(err)")
            
            DispatchQueue.main.async {
                guard err == nil else {
                    self.appendError(msg: "响应 \(reply) 错误\(err?.localizedDescription)")
                    return
                }
                self.appendMsg(msg: "响应 \(reply) 错误\(err?.localizedDescription)")
            }
        }
        
        print("doConnect22")
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         print("dddddd")
        
        self.Connect()
    }
    
    @IBAction func addText(_ sender: Any) {
        
        let text2 = NSTextField()
        text2.stringValue = """
        如果，你觉得你的 Mac 开发很菜
        加入我们群
        你就会发现，你不是最菜的

        群号：644096295
        """
        self.stack2.addArrangedSubview(text2)
    }
    
    func appendMsg(msg: String) {
        let text = NSTextField()
        text.isSelectable = true
        text.isEditable = false
        text.isBordered = false
//        text.wantsLayer = true
//        text.layer?.borderWidth = 0.0
        text.stringValue = msg
        text.backgroundColor = NSColor.green
        self.stack2.addArrangedSubview(text)
    }
    func appendError(msg: String) {
        let text = NSTextField()
        text.isSelectable = true
        text.isEditable = false
        text.isBordered = false
//        text.wantsLayer = true
//        text.layer?.borderWidth = 0.0
        text.stringValue = msg
        text.textColor = NSColor.white
        text.backgroundColor = NSColor.red
        self.stack2.addArrangedSubview(text)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func setState(ok: Bool) {
        if ok {
            self.labConn.stringValue = "已连接"
        }
    }
    
    func appendText(text: String) {

        let at = NSText(frame: NSRect(x:10,y:10,width:100,height:100))
        at.string = text
    //                    self.msgOut.addSubview(at)
      //  self.msgOut.documentView!.insertText(recievedText + "\n")
       // self.msgOut.documentView!.addSubview(at)
//        let contentView = NSView(frame: NSRect(x: 0, y: 0, width: 1000, height: 1000))
//        contentView.addSubview(at)
       // self.scrollView.documentView = contentView
        //self.scrollView.documentView?.addSubview(at)
        
 
        //        self.stackView.addArrangedSubview(at)
                let at2 = NSText()
                at2.string = "text222"
                //self.stackView.addView(at, in: .center)
        //self.scrollView.documentView = at2
    }

    func Connect() {
        do {
            let uri = "ws://localhost:7402/comet"
            
        let client = WebSocketClient(uri)!
            client.onText{ recievedText in  // receieved String
                 // do something with recieved String
                print("接收到文字内容 \(recievedText)")
    
            }
            client.onError { err, status in
                print("出现异常 \(err) === \(status)")
            }
            client.onBinary { dataNil in
                
                guard let data = dataNil as? Data else {
                    print("空的数据内容")
                    return
                }
                print("接收到二进制内容 \(data)")
               // data.copyBytes( to:&code, count:4)
                do {
                    
                    var code: UInt8 = 0
                    if data.bytes.count > 0 {
                        code = data.bytes[0]
                    }
                    print( code, "|", code.bigEndian, "|") // 42.13
                    
                } catch let err {
                           print("出现异常 \(err)")
                       }
                 
                 
                 DispatchQueue.main.async {
                                    self.labConn.textColor = NSColor.green
                                    self.labConn.stringValue = "已连接"
                                
                                }
            }
        try client.connect()
            let sign = "Ae4op8XF3Tk5eiX92T0t0IY/8wyFTyaUshDgOXilPQ4VAQCvYkJeKvAAAAAAAABOhw=="
            let device = "device"
            
            let auth = "\(sign)\n\(device)\n"
            client.sendBinary(auth.data(using: String.Encoding.utf8)!)
        } catch let err {
            print("出现异常 \(err)")
        }
    }

    
}

//
//  AppDelegate.swift
//  SwiftCDemo4
//
//  Created by Larry on 2020/10/29.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: QQBaseWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        //let contentView = ContentView()
//        let contentView = GridLayoutView()
        let contentView = WaterfallsView()
       // let contentView = LayoutView()

        // Create the window and set the content view.
        window = QQBaseWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        // 测试ocr识别
        //testRunC()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    func testRunC() -> Void {
        print("\n----------------------------\n\n")
        printHellow();
        let cRandomInt = getRandomInt();
        print("\n")
        print("收到C函数的随机数是：\(cRandomInt)");
        
        let person = createBy("peter", 14);
        printPersonInfo(person);
        let cName = getPersonName(person);
        let name = String(cString: cName!);
        print("fetch name is：\(name)");
        
        destoryModel(person);
        
        
        
    }
}

class QQBaseWindow : NSWindow, NSWindowDelegate {
    
    weak var qqDelegate: QQBaseWindowProtocol?
       
       override var canBecomeKey: Bool{
   //        self.delegate = self
           return true
       }
    
    
    //window尺寸变化
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
//        if let delegate = self.qqDelegate,delegate.responds(to: #selector(QQBaseWindowProtocol.windowWillResize(size:))) {
//            delegate.windowWillResize(size: frameSize)
//        }
        //frameSize.width = sender.frame.size.width + 10
        var newSize = NSSize(width: frameSize.width, height: frameSize.height)
//        if frameSize.width - sender.frame.size.width > 0 {
//            newSize.width = sender.frame.size.width + 50
//        } else if frameSize.width - sender.frame.size.width < 0 {
//           // newSize.width = sender.frame.size.width - 50
//        }
        
        // 按指定步长调整宽度
        //newSize.width = CGFloat((Int(frameSize.width) / 150 + 1) * 150)
        
        if newSize.width < 900 {
            newSize.width = 900
        }
        if newSize.width > 1600 {
            newSize.width = 1600
        }
        if newSize.height < 600 {
            newSize.height = 600
        }
        if newSize.height > 1000 {
            newSize.height = 1000
        }
        print("window delegate \(sender.frame.size) \(frameSize) \(newSize)")
        return newSize
    }
    
}
 

@objc protocol QQBaseWindowProtocol:NSObjectProtocol {
    @objc func windowWillResize(size:NSSize);
}

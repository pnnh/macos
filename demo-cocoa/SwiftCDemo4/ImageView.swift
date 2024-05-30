//
//  ImageView.swift
//  SwiftCDemo4
//
//  Created by Larry on 2020/11/14.
//

import Foundation
import SwiftUI
import Cocoa


struct SJImageView: NSViewRepresentable {
    typealias NSViewType = NSImageView
    
    func updateNSView(_ nsView: NSImageView, context: Context) {
        print("SJImageView updateView")
    }
    
    private var image:NSImage
    
    init(image: NSImage ) {
        self.image = image
    }
     
    
    func makeNSView(context: Context) -> NSImageView {

        let rect = NSRect(x: 0, y: 0, width: 100, height: 100)
        let view = NSImageView(frame: rect)
        //view.imageScaling = .scaleProportionallyDown
        view.animates = true
        view.image = self.image
         
        return view
    }
    
     
}

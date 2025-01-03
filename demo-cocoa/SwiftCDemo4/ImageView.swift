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
    
    private var image:NSImage?
    
    
    init(image: NSImage) {
        self.image = image
    }
    
    init(imagePath: String) {
        self.image = NSImage(contentsOfFile: imagePath)
    }
     
    
    func makeNSView(context: Context) -> NSImageView {
        
        let rect = NSRect(x: 0, y: 0, width: 600, height: 600)
        let view = NSImageView(frame: rect)
        view.imageFrameStyle = .photo
        view.isEditable = false
        view.imageScaling = .scaleProportionallyUpOrDown
            view.animates = true
        
        if self.image != nil {
            view.image = self.image
        }
         
        return view
    }
    
     
}

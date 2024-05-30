//
//  MainImageGrid.swift
//  SwiftCDemo4
//
//  Created by Larry on 2020/11/14.
//

import Foundation
import SwiftUI
import Combine

struct GridView: View {
    @Binding var columnCount: Int
    @Binding var dataFiles: [String]
    
    init(colCount: Binding<Int>, files: Binding<[String]> ) {
        self._columnCount = colCount
        self._dataFiles = files
    }
    
    @State var active:(Int, Int) = (0, 0)
    
    func getPath(index: Int) -> String {
        if index < dataFiles.count {
            return dataFiles[index]
        }
        return ""
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8){
            
            ForEach(0..<dataFiles.count / Int(columnCount) + 1, id: \.self) { rowIndex in
                HStack(alignment: .top, spacing: 8) {
                    ForEach(0..<Int(columnCount), id: \.self) { colIndex in
                        
                        Button(action: {
                            print("jjjdfs3")
                            self.active = (rowIndex, colIndex)
                            // 打开窗口
                            showWindow(imgPath: getPath(index: rowIndex * Int(columnCount) + colIndex))
                        }) {
                            EmoView2(path: getPath(index: rowIndex * Int(columnCount) + colIndex),
                                     colWidth: 0 )
                                .frame(  maxWidth: .infinity)
                                .background(Color.white).cornerRadius(2).overlay(
                            
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(Color.blue, lineWidth: self.active == (rowIndex, colIndex) ? 2 : 0 )
                                )
                        }.buttonStyle(EmptyButtonStyle()).padding(2)
                        //Text("sss \(gp2.size.width), \(gp2.size.height)")
                        
                    }
                }
            }
        }
    }
    
}


//class Model: ObservableObject {
//    init() {
//        print("Model Created")
//    }
//    @Published var imageText: String = "图片备注"
//    @Published var show: Bool = false
//}

struct EmoView2: View {
    
    private var columnWidth: Double
    //    @State private var model: ImageModel3
    //@State private var show: Bool = false
    private var path: String
    
   // @ObservedObject var model2 = Model()
    
    init(path: String, colWidth: Double ) {
        self.path = path
        self.columnWidth = colWidth
        //self.model = ImageModel(Path: path, Text: "新")
        //_show = State(initialValue: false)
        //        self.model2.show = false
       // print("onAppear \(path) \(self.model2.show)") 
    }
    
    
    func getNSImage() -> ImageWrapper? {
        
        
        //        if model.Path == "" {
        //            return nil
        //        }
        let imgPath = self.path
        //        if !imgPath.hasPrefix("/") {
        //            imgPath = "Documents/\(self.model.Path)"
        //        }
        //print("aaa \(self.model) \(imgPath)")
        
        if let nsImg = NSImage(contentsOfFile: imgPath) {
            //print("width height \(nsImg.size.width) \(nsImg.size.height)")
            let width = nsImg.size.width
            let height = nsImg.size.height
            //print("width2 \(height)")
            
            return ImageWrapper(Image: nsImg, width: width, height: height,
                                filePath: imgPath)
            
        }
        
        return nil
        
    }
    
    
    var body: some View {
            
            VStack(alignment: .center, spacing: nil) {
                
               // Spacer(minLength: 0)
                
                    if let nsImg = getNSImage() {
                    HStack(alignment: .center) {
                        Spacer(minLength: 0)
                            Image(nsImage: nsImg.Image)
                                .resizable()
                                //.frame(maxWidth: .infinity)//.border(Color.gray, width: 0.5)
                                //.frame(height: gp.size.width)
                                .aspectRatio(1, contentMode: .fit)
                            
                            //.clipped()//.background(Color.pink)
                        //.frame(width: nsImg.width, height: nsImg.height)
                        
                        Spacer(minLength: 0)
                    }//
                //Spacer(minLength: 0)
//                HStack {
//                    Text("图片备注").foregroundColor(Color.gray)
//                        .font(Font.system(size: 10, design: .default))
//                    Spacer()
//                }.padding(2)//.frame(height:20)
            }
        }
        
        
    }
    
    
}

struct ImageWrapper {
    var Image: NSImage
    var width: CGFloat
    var height: CGFloat
    var filePath: String
}

struct EmptyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

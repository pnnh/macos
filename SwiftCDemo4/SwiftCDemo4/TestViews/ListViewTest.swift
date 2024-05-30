//
//  ListViewTest.swift
//  SwiftCDemo4
//
//  Created by Larry on 2020/11/22.
//

import Foundation
import SwiftUI

struct ListContentView: View {
    @State var items = Array(1...600)

    var body: some View {
        VStack {
            Button("Shuffle") {
                self.items.shuffle()
            }

            List(items, id: \.self) {
                Text("Item \($0)")
            }
            .id(UUID())     // 取消注释该句UI刷新将很慢，界面卡顿；因为每次swiftui都会对比子元素，但如果id随机就会认为是新的list不再对比而是直接替换
        }
    }
}

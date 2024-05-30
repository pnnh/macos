//
//  TimerTest.swift
//  SwiftCDemo4
//
//  Created by Larry on 2020/11/22.
//

import Combine
import SwiftUI

class FrequentUpdater: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    var timer: Timer?
    @Published var text : String=""

    init() {
        let observer: Subscribers.Sink<Void,Never> = Subscribers.Sink(receiveCompletion: {_ in
            print("completed: ")
        }, receiveValue: {
            print("received value2: ")
            self.text = UUID().uuidString
            
        })
        objectWillChange.subscribe(observer)
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true
        ) { _ in
            self.objectWillChange.send()
        }
    }
}

struct TimerContentView: View {
    @ObservedObject var updater = FrequentUpdater()
    @State private var tapCount = 0
    
    init() {
        
    }

    var body: some View {
        VStack {
            //Text("\(UUID().uuidString)")
            Text("uuid \(self.updater.text)")

            Button(action: {
                self.tapCount += 1
            }) {
                Text("Tap count: \(tapCount)")
            }
        }
    }
}

//
//  Poli.swift
//  ProbaTextAnimation
//
//  Created by Ivan Dimitrov on 22.11.20.
//

import Foundation
import SwiftUI

struct ContentView2: View {
    @State private var flag = false
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.green)
                .frame(width: 100, height: 50)
                .modifier(PctModifier(pct: self.flag ? 0 : 1))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.flag.toggle()
                    }
            }
        }
    }
}

struct PctModifier: AnimatableModifier {
    var pct: CGFloat = 0
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        content.overlay(Text("\(Int(pct * 100))").font(.largeTitle).foregroundColor(.primary))
    }
}

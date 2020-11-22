//
//  TextAnimetion.swift
//  ProbaTextAnimation
//
//  Created by Ivan Dimitrov on 22.11.20.
//

import Foundation
import SwiftUI


struct ContentView3: View {
    
    @State private var flag   = false
    @State private var isShow = true
    @State var colorShadow : Color = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    
    var timer : Timer {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: flag)  { _ in
            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                self.flag.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            
            Button(action: {
                self.isShow.toggle()
// na vcako natiskane animira
//                            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
//                                self.flag.toggle()
//                            }

            }) {
                if self.isShow {
                    Rectangle()
                        .modifier( WaveTextModifier(text: "polivane", waveWidth: self.flag ? 10 : 500, pct:  self.flag ? 1 : 0 , size: 26))
                        .frame(width: 300, height: 70, alignment: .center)
                        .background(
                            ZStack {
                                Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(.white)
                                    .blur(radius: 4.0)
                                    .offset(x: -8.0, y: -8.0) })
                
                         .foregroundColor(.gray)
                         .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                         .shadow(color: colorShadow, radius: 20, x: 20.0  , y:  20.0)
                         .shadow(color: Color.white, radius: 20, x: -20.0 , y: -20.0)
                      
                         .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: self.isShow))
                }else{
                    Text("polivane")
                        .font(.system(size: 26))
//                        .font(Font.custom("Menlo", size: 26).bold())
                        .frame(width: 300, height: 70, alignment: .center)
                        .background(
                            ZStack {
                                Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .foregroundColor(.white)
                                    .blur(radius: 4.0)
                                    .offset(x: -8.0, y: -8.0) })
                
                         .foregroundColor(.gray)
                         .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                         .shadow(color: colorShadow, radius: 20, x: 20.0  , y:  20.0)
                         .shadow(color: Color.white, radius: 20, x: -20.0 , y: -20.0)
                }
            }

            

        }
        .onAppear(){
            timer
        }
    }
 

   
}

struct WaveTextModifier: AnimatableModifier {
    let text: String
    let waveWidth: Int
    var pct: Double
    var size: CGFloat
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        
        HStack(spacing: 0) {
            ForEach(Array(text.enumerated()), id: \.0) { (n, ch) in
                Text(String(ch))
                    .font(.system(size:self.size))
//                   .font(Font.custom("Menlo", size: self.size).bold())
                    .scaleEffect(self.effect(self.pct, n, self.text.count, Double(self.waveWidth)))
            }
        }
    }
    
    func effect(_ pct: Double, _ n: Int, _ total: Int, _ waveWidth: Double) -> CGFloat {
        let n = Double(n)
        let total = Double(total)
        
        return CGFloat(1 + valueInCurve(pct: pct, total: total, x: n/total, waveWidth: waveWidth))
    }
    
    func valueInCurve(pct: Double, total: Double, x: Double, waveWidth: Double) -> Double {
        let chunk = waveWidth / total
        let m = 1 / chunk
        let offset = (chunk - (1 / total)) * pct
        let lowerLimit = (pct - chunk) + offset
        let upperLimit = (pct) + offset
        guard x >= lowerLimit && x < upperLimit else { return 0 }
        
        let angle = ((x - pct - offset) * m)*360-90
        
        return (sin(angle.rad) + 1) / 2
    }
}

extension Double {
    var rad: Double { return self * .pi / 180 }
    var deg: Double { return self * 180 / .pi }
}

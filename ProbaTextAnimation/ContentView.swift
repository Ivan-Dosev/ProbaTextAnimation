//
//  ContentView.swift
//  ProbaTextAnimation
//
//  Created by Ivan Dimitrov on 22.11.20.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShow : Bool = false
    
    var body: some View {
        VStack {

            ContentView3()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

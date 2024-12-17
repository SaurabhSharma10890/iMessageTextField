//
//  ContentView.swift
//  iMessageTextField
//
//  Created by Saurabh Sharma on 07/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    
    var body: some View {
        
        VStack {
            MessageTextField(inputText: $inputText)
        }
        .padding(.bottom, 10)
    }
}


#Preview {
    ContentView()
}

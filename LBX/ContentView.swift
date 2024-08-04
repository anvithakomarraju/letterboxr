//
//  ContentView.swift
//  LtrBoxr
//
//  Created by Ramanand Komarraju on 8/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {
                // Add the action for the button here
                print("Sign In button tapped")
            }) {
                Text("Sign In")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }        }
        .padding()
    }
}

#Preview {
    ContentView()
}

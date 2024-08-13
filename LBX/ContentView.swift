//
//  ContentView.swift
//  LtrBoxr
//
//  Created by Ramanand Komarraju on 8/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var htmlContent: String = """
    <h1>Hello, World!</h1>
    <p>This is a paragraph of HTML content.</p>
    """

    var body: some View {
        VStack {
            // Existing UI components
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
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
            }
            
            // Spacer to add some space between existing components and new components
            Spacer().frame(height: 20)
            
            // HTML rendering functionality
            TextEditor(text: $htmlContent)
                .frame(height: 150)
                .border(Color.gray, width: 1)
                .padding()

            HTMLTextView(htmlContent: htmlContent)
                .padding()
                .border(Color.gray, width: 1)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

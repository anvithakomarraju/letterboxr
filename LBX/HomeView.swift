//
//  HomeView.swift
//  LtrBoxr
//
//  Created by Ramanand Komarraju on 8/2/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var userName: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "house")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Spacer()
            
            Text(userName)
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userName: "John Doe")
    }
}

//
//  HomeView.swift
//  LtrBoxr
//
//  Created by Ramanand Komarraju on 8/2/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var navigateToProfile = false
    var userName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    Spacer()
                    
                    Image("logo") // Ensure this image is in your assets with this name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 550, height: 550)
                    
                    Spacer()
                        .frame(height: 125)
                }
                
                NavigationLink(destination: UserProfileView(), isActive: $navigateToProfile) {
                    EmptyView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateToProfile = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userName: "John Doe")
    }
}

//
//  SplashScreenView.swift
//  movie-app-ios
//
//  Created by Luu Phan on 14/02/2023.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            Image("NetflixLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 32)
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(
                        CircularProgressViewStyle(
                            tint: .red)
                    )
                    .scaleEffect(1.5)
                    .padding(.bottom, 32)
                
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

//
//  SwiftUIView.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import SwiftUI
import Common
import Resources
import Domain

public enum SplashStep: Step {
    case home
    case onboard
}

public struct SplashView: View {
    @EnvironmentObject var router: Router<SplashStep>
    
    @StateObject var viewModel = SplashViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            AppImages.logoNetflix()
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dLog("+++++ splash screen receive +++++")
                viewModel.dispatch(action: .checkShowOnboarding)
                
            }
        }
        .ignoresSafeArea()
        .onReceive(viewModel.$nextStep) { step in
            guard let step else {
                return
            }
            router.go(to: step)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

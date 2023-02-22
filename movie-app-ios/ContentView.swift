//
//  ContentView.swift
//  movie-app-ios
//
//  Created by Luu Phan on 16/02/2023.
//

import SwiftUI
import Domain
import Common
import UI
import DependencyKit

enum ContentStep: Step {
    case home
    case onboarding
}

enum ContentViewType {
    case splash
    case onboarding
    case home
}

struct ContentContainerView: View {
    
    @StateObject var onboardingViewModel = Container.showOnboardingViewModel()
    
    @StateObject var router = ContentStep.router()
    @StateObject var splashRouter: Router<SplashStep> = SplashStep.router()
    
    @State var viewType: ContentViewType = .splash
    
    var body: some View {
        buildBody()
    }
    
    @ViewBuilder
    func buildBody() -> some View {
        switch viewType {
        case .splash:
            SplashView()
                .environmentObject(splashRouter)
                .onReceive(splashRouter.stream) { step in
                    switch step {
                    case .home:
                        viewType = .home
                    case .onboard:
                        viewType = .onboarding
                    }
                }
        case .onboarding:
            OnboardingView(viewModel: onboardingViewModel)
        case .home:
            Text("Home screen")
        }
    }
}

struct ContentContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentContainerView()
    }
}

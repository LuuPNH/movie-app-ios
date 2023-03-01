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
import Resources

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
    
    //Color
    @SwiftUI.Environment(\.colorScheme) var colorScheme
    @State var themeEnvironmentValue = AppTheme.light
    @State var themeManager = ThemeManager.shared
    
    
    //Container
    @StateObject var onboardingViewModel = Container.showOnboardingViewModel()
    @StateObject var homeViewModel = Container.homeViewModel()
    
    
    //Router
    @StateObject var router = ContentStep.router()
    @StateObject var splashRouter: Router<SplashStep> = SplashStep.router()
    @StateObject var onBoardingRouter: Router<OnboardingStep> = OnboardingStep.router()
    
    @State var viewType: ContentViewType = .splash
    
    var body: some View {
        buildBody()
            .onChange(of: colorScheme) { newValue in
                if themeManager.themePublisher.value == .light {
                    checkColorScheme(newValue)
                }
            }
            .onReceive(themeManager.themePublisher) { theme in
                if theme != .light {
                    themeEnvironmentValue = theme
                }
            }
            .onAppear {
                checkColorScheme(colorScheme)
            }
    }
    
    func checkColorScheme(_ colorScheme: ColorScheme) {
        if colorScheme == .dark {
            themeEnvironmentValue = .dark
        } else {
            themeEnvironmentValue = .light
        }
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
                .environmentObject(onBoardingRouter)
                
                .onReceive(onBoardingRouter.stream) { step in
                    
                    switch step {
                    case .home:
                        viewType = .home
                    }
                }
        case .home:
            HomeView(viewModel: homeViewModel)
                .environment(\.theme, themeEnvironmentValue)
        }
    }
}

struct ContentContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentContainerView()
    }
}

////
////  ContentView.swift
////  App
////
////  Created by Phat Le on 04/04/2022.
////
//
//import SwiftUI
//import Common
//import Domain
//import Resources
//import Splash
//import Home
//
//enum ContentStep: Step {
//    case home
//}
//
//enum ContentViewType {
//    case splash
//    case home
//}
//
//struct ContentContainerView: View {
//    @SwiftUI.Environment(\.colorScheme) var colorScheme
//
//    @StateObject var router = ContentStep.router()
//    @StateObject var splashRouter = SplashStep.router()
//    @StateObject var homeRouter = HomeStep.router()
//    @StateObject var ekycContainerStep = EkycContainerStep.router()
//
//    @State var themeEnvironmentValue = AppTheme.default
//    @State var viewType: ContentViewType = .splash
//    @State var themeManager = ThemeManager.shared
//
//    @State var ekycType: DocumentType?
//    @State var ekycToken = ""
//
//    var body: some View {
//        buildBody()
//            .hideNavigationBar()
//            .sheet(model: $ekycType) { type in
//                EkycContainerView(cardType: type)
//                    .environmentObject(ekycContainerStep)
//                    .onReceive(ekycContainerStep.stream) { step in
//                        switch step {
//                        case .closeEkyc:
//                            withAnimation {
//                                ekycType = nil
//                            }
//                        }
//                    }
//            }
//            .environment(\.theme, themeEnvironmentValue)
//            .onChange(of: colorScheme) { newValue in
//                if themeManager.themePublisher.value == .none {
//                    checkColorScheme(newValue)
//                }
//            }
//            .onReceive(themeManager.themePublisher) { theme in
//                if theme != .none {
//                    themeEnvironmentValue = theme
//                }
//            }
//            .onAppear {
//                checkColorScheme(colorScheme)
//            }
//            .onReceive(router.stream) { step in
//                switch step {
//                case .home:
//                    viewType = .home
//                }
//            }
//    }
//
//    func checkColorScheme(_ colorScheme: ColorScheme) {
//        if colorScheme == .dark {
//            themeEnvironmentValue = .dark
//        } else {
//            themeEnvironmentValue = .default
//        }
//    }
//
//    @ViewBuilder
//    func buildBody() -> some View {
//        switch viewType {
//        case .home:
//            HomeView()
//                .environmentObject(homeRouter)
//                .onReceive(homeRouter.stream) { step in
//                    switch step {
//                    case let .ekyc(token, type):
//                        ekycToken = token
//                        ekycType = .init(rawValue: type)
//                    }
//                }
//        case .splash:
//            SplashView(logo: _AppImages.logo())
//                .environmentObject(splashRouter)
//                .onReceive(splashRouter.stream) { step in
//                    switch step {
//                    case .home:
//                        router.go(to: .home)
//                    }
//                }
//        }
//    }
//}
//
//#if DEBUG
//struct ContentContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentContainerView()
//            .preview()
//    }
//}
//#endif

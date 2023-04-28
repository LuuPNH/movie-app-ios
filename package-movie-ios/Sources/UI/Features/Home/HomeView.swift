//
//  HomeView.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI
import Resources
import DependencyKit
import Common
import Domain
import PopupView

public struct HomeView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    @EnvironmentObject var router: Router<HomeStep>
    
    @StateObject var error: AppError<Error> = AppError()
    
    @StateObject var headerHomeRouter: Router<HeaderHomeStep> = HeaderHomeStep.router()
    
    @StateObject var carouselRouter: Router<CarouselStep> = CarouselStep.router()
    
    @StateObject var categoriesRouter: Router<CategoriesStep> = CategoriesStep.router()
    
    @StateObject var todayRouter: Router<TodayStep> = TodayStep.router()
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State var showPopupError: Bool = false
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $viewModel.homeTab) {
            ScrollView {
                VStack(alignment: .leading) {
                    HomeHeaderView()
                        .environmentObject(headerHomeRouter)
                        .onReceive(headerHomeRouter.stream) { step in
                            
                        }
                    SearchHomeView()
                    CarouselView()
                        .environmentObject(carouselRouter)
                        .environmentObject(error)
                        .onReceive(carouselRouter.stream) { step in
                            print("++++ CarouselRouter step: \(step)")
                        }
                    
                    CategoriesView()
                        .environmentObject(categoriesRouter)
                        .environmentObject(error)
                        .onReceive(categoriesRouter.stream) { step in
                            print("++++ CategoriesView step: \(step)")
                        }
                    TodayView()
                        .environmentObject(todayRouter)
                        .onReceive(todayRouter.stream) { step in
                            print("++++ TodayView step: \(step)")
                        }
                    
                }
                .tag(HomeTab.home)
                .onReceive(error.stream) { error in
                    if showPopupError { return }
                    showPopupError = true
                }
                .popup(isPresented: $showPopupError) {
                    DialogView(text: error.errors[0].localizedDescription)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.primary)
            
            Text("Search")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.search)
            
            Text("Download")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.download)
            
            Text("Profile")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tag(HomeTab.profile)
        }
        .foregroundColor(theme.primary)
        .overlay {
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    
                    ForEach(HomeTab.allCases, id: \.self) { tab in
                        buildTab(tab)
                            .padding(.horizontal, 8)
                    }
                    
                    
                }
                .padding(.horizontal, 45)
                .frame(height: 60)
                .frame(maxWidth: .infinity,alignment: .bottom)
                .background(theme.primary)
            }
            .animation(.easeInOut, value: viewModel.homeTab)
            
        }
    }
    
    @ViewBuilder
    func buildTab(_ tab: HomeTab) -> some View {
        let info = infoTab(tab)
        HStack {
            Image(systemName: info.image)
                .frame(width: 24, height: 24)
            if tab == viewModel.homeTab {
                Text(info.text)
                    .font(.system(size: 12))
                    .lineLimit(1)
            }
        }
        .foregroundColor(tab == viewModel.homeTab ? theme.blue12CDD9 : theme.grey92929D)
        .padding(.horizontal, 10)
        .frame(height: 40)
        .background(tab == viewModel.homeTab ? theme.blue252836 : theme.primary)
        .cornerRadius(16)
        .onTapGesture {
            viewModel.goTab(tab: tab)
        }
    }
    
    func infoTab(_ tab: HomeTab) -> (image: String, text: String) {
        switch tab {
        case .home:
            return (image: "house.fill", text: "Home")
        case .search:
            return (image: "magnifyingglass", text: "Search")
        case .download:
            return (image: "arrow.down.to.line.compact", text: "Download")
        case .profile:
            return (image: "person.fill", text: "Profile")
        }
    }
}

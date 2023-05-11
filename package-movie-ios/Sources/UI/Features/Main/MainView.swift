//
//  MainView.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import SwiftUI
import Common
import Resources
import Domain

public enum MainNavigator {
    case main
    case detail(idMovie: Int)
}

public struct MainView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    
    @ObservedObject var homeRouter: Router<HomeStep> = Router<HomeStep>()
    
    @StateObject var appError: AppError = AppError<Error>()
    
    @State var showPopupError: Bool = false
    
    @State var mainNavigator: MainNavigator?
    
    public init() {}
    
    public var body: some View {
        
        NavigationView {
            TabView(selection: $viewModel.appTab) {
                
                HomeView()
                    .environmentObject(homeRouter)
                    .environmentObject(appError)
                    .tag(AppTab.home)
                    .onReceive(homeRouter.stream) { step in
                        switch step {
                        case let .goDetail(idMovie):
                            mainNavigator = .detail(idMovie: idMovie)
                        case .home:
                            return
                        }
                    }
                    .navigation(model: $mainNavigator) { navi in
                        switch navi {
                        case let .detail(idMovie):
                            DetailView(idMovie: idMovie)
                                .environmentObject(appError)
                        default:
                            EmptyView()
                        }
                    }
                
                Text("Search")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tag(AppTab.search)
                
                Text("Download")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tag(AppTab.download)
                
                Text("Profile")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .tag(AppTab.profile)
            }
            
            .foregroundColor(theme.primary)
            .overlay {
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        
                        ForEach(AppTab.allCases, id: \.self) { tab in
                            buildTab(tab)
                                .padding(.horizontal, 8)
                        }
                    }
                    .padding(.horizontal, 45)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity,alignment: .bottom)
                    .background(theme.primary)
                }
                .animation(.easeInOut, value: viewModel.appTab)
            }
        }
        .onReceive(appError.stream, perform: { error in
            if showPopupError { return }
            showPopupError = true
        })
        .popup(isPresented: $showPopupError) {
            DialogView(text: appError.errors[0].localizedDescription)
        }
    }
    
    @ViewBuilder
    func buildTab(_ tab: AppTab) -> some View {
        let info = infoTab(tab)
        HStack {
            Image(systemName: info.image)
                .frame(width: 24, height: 24)
            if tab == viewModel.appTab {
                Text(info.text)
                    .font(.system(size: 12))
                    .lineLimit(1)
            }
        }
        .foregroundColor(tab == viewModel.appTab ? theme.blue12CDD9 : theme.grey92929D)
        .padding(.horizontal, 10)
        .frame(height: 40)
        .background(tab == viewModel.appTab ? theme.blue252836 : theme.primary)
        .cornerRadius(16)
        .onTapGesture {
            viewModel.dispatch(action: .switchTab(tab: tab))
        }
    }
    
    func infoTab(_ tab: AppTab) -> (image: String, text: String) {
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

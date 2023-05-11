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


public struct HomeView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    @EnvironmentObject var router: Router<HomeStep>
    
    @StateObject var headerHomeRouter: Router<HeaderHomeStep> = HeaderHomeStep.router()
    
    @StateObject var carouselRouter: Router<CarouselStep> = CarouselStep.router()
    
    @StateObject var categoriesRouter: Router<CategoriesStep> = CategoriesStep.router()
    
    @StateObject var todayRouter: Router<TodayStep> = TodayStep.router()
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HomeHeaderView()
                    .environmentObject(headerHomeRouter)
                    .onReceive(headerHomeRouter.stream) { step in
                        
                    }
                SearchHomeView()
                CarouselView()
                    .environmentObject(carouselRouter)
                    .onReceive(carouselRouter.stream) { step in
                        switch step {
                        case let .goDetail(id):
                            viewModel.dispatch(action: .goDetail(idMovie: id))
                        }
                    }
                
                CategoriesView()
                    .environmentObject(categoriesRouter)
                    .onReceive(categoriesRouter.stream) { step in
                        switch step {
                        case let .goDetail(id):
                            viewModel.dispatch(action: .goDetail(idMovie: id))
                        }
                    }
                TodayView()
                    .environmentObject(todayRouter)
                    .onReceive(todayRouter.stream) { step in
                        switch step {
                        case let .goDetail(id):
                            viewModel.dispatch(action: .goDetail(idMovie: id))
                        }
                    }
            }
            .onReceive(viewModel.$step) { step in
                router.go(to: step)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.primary)
        
    }
    
    
}

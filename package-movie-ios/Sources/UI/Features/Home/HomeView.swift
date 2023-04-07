//
//  HomeView.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI
import Resources
import DependencyKit

public struct HomeView: View {
    
    @Environment(\.theme) var theme: AppTheme
    
    @StateObject var imageCacheApp = ImageCache()
    
    @ObservedObject var viewModel:HomeViewModel
    
    @StateObject var carouselViewModel = Container.carouselViewModel()
    
    @StateObject var categoriesViewModel = Container.categoriesViewModel()
    
    public init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        TabView {
            VStack(alignment: .leading) {
                HomeHeaderView()
                    .padding(.horizontal, 16)
                SearchHomeView()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                CarouselView(viewModel: carouselViewModel)
                CategoriesView(viewModel: categoriesViewModel)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(theme.primary)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            Text("Game")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Game")
                }
            
            Text("Video")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tabItem {
                    Image(systemName: "square.and.arrow.down")
                    Text("Video")
                }
            
            Text("Profile")
                .font(.system(size: 40, weight: .bold, design: .default))
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .environmentObject(imageCacheApp)
    }
}
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: HomeViewModel())
//    }
//}

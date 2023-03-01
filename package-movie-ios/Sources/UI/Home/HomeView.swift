//
//  HomeView.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI
import Resources

public struct HomeView: View {
    
    @Environment(\.theme) var theme: AppTheme
    
    @ObservedObject var viewModel:HomeViewModel
    
    public init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        TabView {
            HStack {
                Text("Trending")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                LinearGradient(gradient: Gradient(colors: [theme.blue2B5876, theme.purple4E4376]), startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea(edges: .top)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Trending")
            }
            Text("Friends Screen")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Friends")
                }
            Text("Nearby Screen")
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Nearby")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

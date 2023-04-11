//
//  SwiftUIView.swift
//  
//
//  Created by Luu Phan on 11/04/2023.
//

import SwiftUI
import Resources

struct TabviewTest: View {
    
    @Environment(\.theme) var theme: AppTheme
    @State var homeTab: HomeTab = .home
    
    var body: some View {
        TabView(selection: $homeTab) {
            VStack(alignment: .leading) {
                Text("Home")
                    .foregroundColor(theme.whiteShades)
            }
            .tag(HomeTab.home)
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
            .animation(.easeInOut, value: homeTab)
            
        }
    }
    
    @ViewBuilder
    func buildTab(_ tab: HomeTab) -> some View {
        let info = infoTab(tab)
        HStack {
            Image(systemName: info.image)
            if tab == homeTab {
                Text(info.text)
                    .font(.system(size: 12))
                    .lineLimit(1)
            }
        }
        .foregroundColor(theme.blue12CDD9)
        .padding(.horizontal, 10)
        .frame(height: 40)
        .background(theme.blue252836)
        .cornerRadius(16)
        .onTapGesture {
            homeTab = tab
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

struct TabviewTest_Previews: PreviewProvider {
    static var previews: some View {
        TabviewTest()
    }
}

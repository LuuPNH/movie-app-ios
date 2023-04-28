//
//  CategoriesView.swift
//  
//
//  Created by Luu Phan on 24/03/2023.
//

import SwiftUI
import Domain
import Resources
import Combine
import Common

public struct CategoriesView: View {
    
    @EnvironmentObject var router: Router<CarouselStep>
    
    @EnvironmentObject var appError: AppError<Error>
    
    @StateObject var viewModel:CategoriesViewModel = CategoriesViewModel()
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Categories")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(theme.grey92929D)
                .lineLimit(1)
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.tuples.map{ $0.type }, id: \.rawValue) { tab in
                        Text(getNameCategories(tab))
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(tab == viewModel.selectItem.type ? theme.blue12CDD9 : theme.whiteShades)
                            .frame(height: 31)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(tab == viewModel.selectItem.type ? theme.blue171725 : theme.primary)
                            .cornerRadius(8)
                            .onTapGesture {
                                viewModel.goTab(tab)
                            }
                    }
                }
            }
            .padding(.bottom, 16)
            
            CategoriesItem(value: viewModel.selectItem)
            
        }
        .padding(.horizontal, 8)
        .background(theme.primary)
        .onReceive(viewModel.errorHandler.receiveError()) { error in
            appError.pushError(to: error)
        }
    }
    
    func getNameCategories(_ cate: CategoriesMovie) -> String {
        switch (cate) {
        case .nowPlaying:
            return "Now Playing"
        case .topRate:
            return "Top Rate"
        case .upComing:
            return "Coming"
        case .upLatest:
            return "Latest"
        case .popular:
            return "Popular"
        }
    }
}

//
//  TodayView.swift
//  
//
//  Created by Luu Phan on 26/04/2023.
//

import SwiftUI
import Resources
import Common

struct TodayView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    @EnvironmentObject var router: Router<TodayStep>
    
    @StateObject var viewModel: TodayViewModel = TodayViewModel()
    
    init() {}
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Today")
                .font(.system(size: 20))
                .foregroundColor(theme.grey92929D)
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.horizontal, 16)
            ForEach(viewModel.movies) { movie in
                MovieShowDisplay(movie: movie)
            }
            
        }
        .padding(.vertical, 16)
        .background(theme.primary)
    }
}

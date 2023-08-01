//
//  CarouselView.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import SwiftUI
import Resources
import Combine
import NukeUI
import Common
import Domain

struct CarouselView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    @EnvironmentObject var router: Router<CarouselStep>
    
    @EnvironmentObject var appError: AppError<Error>
    
    @StateObject var viewModel: CarouselViewModel = CarouselViewModel()
    
    @StateObject var carouselRouter: Router<DetailStep> = DetailStep.router()
    
    
    init() {}
    
    var body: some View {
        VStack {
            if !viewModel.listImageMovie.isEmpty {
                ACarousel(viewModel.listImageMovie,
                          headspace: UIScreen.screenWidth / 9,
                          sidesScaling: 0.9,
                          autoScroll: .active(3)
                          
                ) { item in
                    LazyImageCustom(url: item.backdropPath)
                        .frame(width: 295, height: 154)
                        .background(theme.blue252836)
                        .cornerRadius(16)
                        .onTapGesture {
                            viewModel.dispatch(action: .goDetail(idMovie: item.id))
                        }
                }
            }
        }
        .frame(height: 180)
        .onReceive(viewModel.errorHandler.receiveError()) { error in
            appError.pushError(to: error)
        }
        .onReceive(viewModel.$step) { step in
            router.go(to: step)
        }
    }
}

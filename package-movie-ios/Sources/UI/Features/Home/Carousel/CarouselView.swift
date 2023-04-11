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

struct CarouselView: View {
    
    @ObservedObject var viewModel:CarouselViewModel
    
    @Environment(\.theme) var theme: AppTheme
    
    init(viewModel: CarouselViewModel) {
        self.viewModel = viewModel
        
    }
    
    var body: some View {
        VStack {
            if !viewModel.listImageMovie.isEmpty {
                ACarousel(viewModel.listImageMovie,
                          headspace: 50,
                          sidesScaling: 0.9,
                          autoScroll: .active(3)
                          
                ) { item in
                    LazyImage(source: ImageRequest(url: URL(string: item.backdropPath))) { state in
                        if let image = state.image {
                            image
                                .frame(width: 295, height: 154)
                                .cornerRadius(16)
                                .overlay(alignment: .bottomLeading) {
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .font(.system(size: 17))
                                            .fontWeight(.bold)
                                            .foregroundColor(theme.whiteShades)
                                        Text(item.releaseDate)
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                            .foregroundColor(theme.grey92929D)
                                            .multilineTextAlignment(.leading)
                                            .padding(.leading, 8)
                                    }
                                    .padding(.leading, 4)
                                    
                                }
                        } else if state.error != nil {
                            Image(systemName: "x.circle")
                        } else {
                            VStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: theme.whiteShades))
                            }
                            .frame(width: 295, height: 154)
                            .background(theme.blue252836)
                            .cornerRadius(16)
                        }
                    }
                }
            }
        }
        .frame(height: 180)
        .onAppear{
            print("++++++++Init get list movie++++++++++")
            viewModel.dispatch(action: .getlist)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView(viewModel: CarouselViewModel())
//    }
//}


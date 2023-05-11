//
//  CategoriesItem.swift
//  
//
//  Created by Luu Phan on 27/03/2023.
//

import SwiftUI
import Resources
import Domain
import NukeUI

struct CategoriesItem: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    let value: ItemCategoriesMovie
    
    var showAll: () -> Void
    
    public init(value: ItemCategoriesMovie, showAll: @escaping () -> Void) {
        self.value = value
        self.showAll = showAll
    }
    
    var body: some View {
        VStack(alignment: value.isLoading ? .center : .leading, spacing: 15) {
            HStack {
                Text("Most popular")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(theme.grey92929D)
                    .lineLimit(1)
                Spacer()
                
                Text("See All")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding(.trailing, 16)
                    .foregroundColor(!value.movies.isEmpty ? theme.blue12CDD9 : theme.grey92929D)
                    .lineLimit(1)
                    .onTapGesture {
                        if value.movies.isEmpty { return }
                        showAll()
                    }
            }
            
            if value.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: theme.whiteShades))
            }
            else if value.movies.isEmpty {
                Text("No movie here!")
                    .font(.system(size: 16))
                    .foregroundColor(theme.whiteShades)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(value.movies) { movie in
                            
                            LazyImage(source: ImageRequest(url: URL(string: movie.backdropPath))) { state in
                                if let image = state.image {
                                    VStack(alignment: .leading) {
                                        image
                                            .frame(width: 135, height: 178)
                                            .padding(.bottom, 4)
                                            .overlay(alignment: .topTrailing) {
                                                HStack(alignment: .center) {
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(theme.orangeFF8700)
                                                        .padding(.all, 4)
                                                        .frame(width: 12, height: 12)
                                                    
                                                    Text(String(format: "%.1f", movie.voteAverage))
                                                        .font(.system(size: 14))
                                                        .foregroundColor(theme.orangeFF8700)
                                                    
                                                }
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(theme.grey252836.opacity(0.32))
                                                .cornerRadius(8)
                                                .padding(.all, 8)
                                                
                                            }
                                        Text(movie.title)
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(theme.grey92929D)
                                            .padding(.horizontal, 8)
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(movie.overview)
                                            .font(.system(size: 10))
                                            .foregroundColor(theme.grey92929D)
                                            .padding(.horizontal, 8)
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        
                                    }
                                    .frame(width: 135, height: 231)
                                    .background(theme.blue252836)
                                    .cornerRadius(16)
                                } else if state.error != nil {
                                    Image(systemName: "x.circle")
                                } else {
                                    VStack {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: theme.whiteShades))
                                    }
                                    .frame(width: 135, height: 231)
                                    .background(theme.blue252836)
                                    .cornerRadius(16)
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 8)
        .background(theme.primary)
        .frame(maxHeight: 235)
    }
}

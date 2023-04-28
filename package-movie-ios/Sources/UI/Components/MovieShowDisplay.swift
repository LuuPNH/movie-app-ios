//
//  MovieShowDisplay.swift
//  
//
//  Created by Luu Phan on 12/04/2023.
//

import SwiftUI
import Resources
import NukeUI
import Domain

public struct MovieShowDisplay: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    var movie: Movie
    
    public init(movie: Movie) {
        self.movie = movie
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LazyImage(source: ImageRequest(url: URL(string: movie.backdropPath))) { state in
                    if let image = state.image {
                        image
                        
                            .overlay(alignment: .topLeading) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(theme.orangeFF8700)
                                        .padding(.all, 4)
                                        .frame(width: 12, height: 12)
                                    
                                    Text(String(format: "%.1f", movie.voteAverage))
                                        .font(.system(size: 14))
                                        .foregroundColor(theme.orangeFF8700)
                                    
                                }
                                .frame(alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(theme.grey252836.opacity(0.32))
                                .cornerRadius(8)
                            }
                            .cornerRadius(8)
                    } else if state.error != nil {
                        Image(systemName: "x.circle")
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: theme.whiteShades))
                    }
                }
                .frame(width: 112, height: 147)
                Spacer()
                    .frame(width: 16)
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.originalLanguage)
                        .font(.system(size: 14))
                        .foregroundColor(theme.whiteShades)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(theme.orangeFF8700)
                        .cornerRadius(8)
                    
                    Text(movie.title)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(theme.grey92929D)
                        .lineLimit(1)
                    HStack {
                        Image(systemName: "calendar")
                            .frame(width: 16)
                        Text(movie.releaseDate)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Image(systemName: "star.bubble")
                            .frame(width: 16)
                        Text(String(movie.voteCount))
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Image(systemName: "film.stack")
                            .frame(width: 16)
                        Text("Action")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Divider()
                        Text(movie.mediaType)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                    }
                    
                    
                }
                .foregroundColor(theme.grey92929D)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(theme.primary)
        
    }
}


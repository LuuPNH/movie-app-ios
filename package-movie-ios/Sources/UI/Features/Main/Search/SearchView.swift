//
//  SearchView.swift
//  
//
//  Created by Hải Lưu on 21/06/2023.
//

import SwiftUI
import Resources
import Common
import Combine

struct SearchView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    @EnvironmentObject var appError: AppError<Error>
    
    @EnvironmentObject var router: Router<SearchStep>
    
    @StateObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        
        VStack {
            SearchContainerView($viewModel.searchKey)
                .onChange(of: viewModel.searchKey) { value in
                    
                }
            
            if viewModel.isLoading {
                ProgressView()
                    .foregroundColor(theme.whiteShades)
            } else if viewModel.searchKey.isEmpty || viewModel.isFirstLoad {
                AppImages.glass()
                Text("Input keywords to search movies")
                
            }
            else if viewModel.searchError != nil {
                VStack {
                    AppImages.error()
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("Search failed!")
                }
            } else if viewModel.movies.isEmpty {
                VStack {
                    AppImages.glass()
                    Text("We are sorry, we can not find the movie")
                    
                    Text("Find your movie by Type title")
                        .foregroundColor(theme.grey)
                    
                }
            } else {
                ScrollView {
                    ForEach(viewModel.movies) { movie in
                        MovieShowDisplay(movie: movie)
                            .onTapGesture {
                                viewModel.dispatch(action: .goDetail(idMovie: movie.id))
                            }
                    }
                }
            }
            Spacer()
        }
        .foregroundColor(theme.whiteShades)
        .font(.system(size: 16))
        .background(theme.primary)
        .onReceive(viewModel.errorHandler.receiveError()) { error in
            appError.pushError(to: error)
        }
        .onReceive(viewModel.$step) { step in
            router.go(to: step)
        }
     }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

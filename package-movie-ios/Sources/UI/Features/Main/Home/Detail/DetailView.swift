//
//  DetailView.swift
//  
//
//  Created by Luu Phan on 08/05/2023.
//

import SwiftUI
import Resources
import Common
import Domain
import NukeUI

public enum DetailNavigator {
    case watchMovie
}

public struct DetailView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: DetailViewModel
    
    @EnvironmentObject var router: Router<DetailStep>
    
    @State var detailNavigator: DetailNavigator?
    
    @EnvironmentObject var appError: AppError<Error>
    
    public init(idMovie: Int) {
        self._viewModel = ObservedObject(wrappedValue: DetailViewModel(idMovie: idMovie))
        viewModel.disPatch(action: .getInfoMovie)
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    .padding(.top, 72)
                    .frame(maxWidth: .infinity)
                } else if viewModel.movie != nil {
                    VStack(alignment: .leading) {
                        LazyImageCustom(url: viewModel.movie!.backdropPath)
                            .frame(height: UIScreen.screenHeight * 0.67)
                            .ignoresSafeArea()
                            .opacity(0.1)
                            .overlay {
                                VStack(spacing: 16) {
                                    Spacer()
                                    
                                    LazyImageCustom(url: viewModel.movie!.backdropPath)
                                        .cornerRadius(12)
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth * 0.56, height: UIScreen.screenHeight * 0.33)
                                    
                                    HStack(spacing: 12) {
                                        HStack {
                                            Image(systemName: "calendar.badge.clock")
                                                .frame(width: 16, height: 16)
                                            Text(viewModel.movie!.releaseDate)
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                        Divider()
                                            .frame(width: 2, height: 16)
                                            .overlay(theme.grey92929D)
                                        
                                        HStack {
                                            Image(systemName: "clock.fill")
                                                .frame(width: 16, height: 16)
                                            Text("\(viewModel.movie!.runtime)")
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                        Divider()
                                            .frame(width: 2, height: 16)
                                            .overlay(theme.grey92929D)
                                        
                                        HStack {
                                            Image(systemName: "star.bubble")
                                                .frame(width: 16, height: 16)
                                            Text("\(viewModel.movie!.voteCount)")
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                    }
                                    .foregroundColor(theme.grey92929D)
                                    
                                    HStack(alignment: .center) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(theme.orangeFF8700)
                                            .padding(.all, 4)
                                            .frame(width: 16, height: 16)
                                        
                                        Text(String(format: "%.1f", viewModel.movie!.voteAverage))
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(theme.orangeFF8700)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(theme.grey252836.opacity(0.32))
                                    .cornerRadius(8)
                                    .padding(.all, 8)
                                    
                                    HStack(spacing: 16) {
                                        HStack {
                                            if viewModel.isLoadingVideo {
                                                ProgressView()
                                                    .frame(width: 24, height: 24)
                                                    .padding(.all, 5.82)
                                            } else {
                                                Image(systemName: "play.fill")
                                                    .foregroundColor(theme.grey92929D)
                                                    .frame(width: 24, height: 24)
                                                    .padding(.all, 5.82)
                                            }
                                            
                                            Text("Play")
                                                .foregroundColor(theme.whiteShades)
                                                .font(.system(size: 16, weight: .semibold))
                                        }
                                        .frame(width: 115, height: 48)
                                        .background(theme.orangeFF8700)
                                        .cornerRadius(32)
                                        .onTapGesture {
                                            viewModel.disPatch(action: .getInfoVideoMovie)
                                        }
                                        
                                        Circle()
                                            .frame(width: 48)
                                            .foregroundColor(theme.grey252836)
                                            .overlay {
                                                Image(systemName: "arrow.down.to.line.compact")
                                                    .foregroundColor(theme.orangeFF8700)
                                                    .frame(width: 24, height: 24)
                                            }
                                        
                                        Circle()
                                            .frame(width: 48)
                                            .foregroundColor(theme.grey252836)
                                            .overlay {
                                                Image(systemName: "paperplane")
                                                    .foregroundColor(theme.blue12CDD9)
                                                    .frame(width: 24, height: 24)
                                            }
                                    }
                                    .padding(.bottom, 16)
                                    
                                }
                            }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Overview")
                                .foregroundColor(theme.grey92929D)
                                .font(.system(size: 16, weight: .semibold))
                            Text(viewModel.movie!.overview)
                                .foregroundColor(theme.whiteShades)
                                .font(.system(size: 16))
                            
                        }
                        .padding(.all, 24)
                        Spacer()
                    }
                } else {
                    VStack {
                        Text("Get info movie failed!")
                            .foregroundColor(theme.whiteShades)
                            .font(.system(size: 16, weight: .semibold))
                        Button {
                            viewModel.disPatch(action: .getInfoMovie)
                        } label: {
                            Text("Refresh")
                                .foregroundColor(theme.primary)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(theme.whiteShades)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.top, 72)
                    .frame(maxWidth: .infinity)
                }
            }
            .background(theme.primary)
            .frame(maxWidth: .infinity)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(theme.grey92929D)
                            .padding(.all, 16)
                            .frame(width: 24, height: 24)
                    }
                    .background(theme.grey252836)
                    .cornerRadius(8)
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(viewModel.movie?.title ?? "--")
                        .foregroundColor(theme.grey92929D)
                        .font(.system(size: 16, weight: .semibold))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "heart.fill")
                        .frame(width: 32, height: 32)
                        .foregroundColor(.red)
                }
            }
            .onReceive(viewModel.errorHandler.errorSubject) { error in
                appError.pushError(to: error)
                Logger.e(error)
            }
            .navigation(model: $viewModel.videoMovie) { value in
                YouTubeView(videoId: value.key)
                    .background(theme.value.primary)
                    .ignoresSafeArea()
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(idMovie: 10)
    }
}

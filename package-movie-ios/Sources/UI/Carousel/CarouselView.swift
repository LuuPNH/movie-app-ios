//
//  CarouselView.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import SwiftUI
import Resources

struct CarouselView: View {
    
    @ObservedObject var viewModel:CarouselViewModel
    
    private var numberOfImages = 3
    private let timer = Timer.publish(every: 10, on: .main, in: .common) .autoconnect()
    
    
    @State private var currentIndex = 0
    
    init(viewModel: CarouselViewModel, numberOfImages: Int = 3, currentIndex: Int = 0) {
        self.viewModel = viewModel
        self.numberOfImages = numberOfImages
        self.currentIndex = currentIndex
    }
    
    var body: some View {
        
        TabView(selection: $currentIndex) {
            ForEach(0..<numberOfImages) {num in
                Image("\(num)")
                    .resizable()
                    .scaledToFill()
                    .overlay(Color.black.opacity(0.4))
                    .tag(num)
            }
        }.tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .onReceive(timer, perform: { _ in
                withAnimation {
                    currentIndex = currentIndex <
                        numberOfImages ? currentIndex + 1 : 0
                }
            })
            .onAppear {
                print("onAppear home view")
                viewModel.dispatch(action: .getlist)
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(viewModel: CarouselViewModel())
    }
}

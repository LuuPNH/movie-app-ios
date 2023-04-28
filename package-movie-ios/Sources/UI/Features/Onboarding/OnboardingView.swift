//
//  SwiftUIView.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import SwiftUI
import Resources
import Common

public struct OnboardingView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel = OnboardingViewModel()
    
    @EnvironmentObject var router: Router<OnboardingStep>
    
    @State var indexPageView:Int = 0
    
    public init() {}
    
    public var body: some View {
        
        VStack {
            GeometryReader { geometry in
                TabView(selection: $indexPageView,
                        content:  {
                    pageOnboarding(image: AppImages.thor())
                        .tag(0)
                    pageOnboarding(image: AppImages.ironman())
                        .tag(1)
                    pageOnboarding(image: AppImages.deadpool(), lastPage: true)
                        .tag(2)
                })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .overlay {
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(0...2, id: \.self) { index in
                            if indexPageView == index {
                                Rectangle()
                                    .frame(width: 50,height: 12)
                                    .cornerRadius(25)
                                    .foregroundColor(Color.red)
                            } else {
                                Circle()
                                    .frame(width: 12,height: 12)
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal, 0)
                            }
                        }
                    }
                    .animation(.linear, value: indexPageView)
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 92)
                }
            }
            
            Spacer()
                .frame(height: 32)
            
        }
        .ignoresSafeArea()
        .background(Color.black.opacity(0.6))
    }
    
    func pageOnboarding(image: Image, lastPage: Bool = false) -> some View {
        VStack {
            Spacer()
            image
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fit)
                .padding(.all, 48)
            Text("Welcome to Netflix")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
                .frame(height: 16)
            Text("The best movie streaming app of the century to make your days great!")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .multilineTextAlignment(.center)
                .padding(.bottom, 48)
            
            if lastPage {
                Button(action: { viewModel.dispatch(action: .goHome) }) {
                    Text("Get started")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color.red)
                .cornerRadius(50)
                .padding(.horizontal, 32)
                .onReceive(viewModel.$nextStep) { step in
                    guard let step else {
                        return
                    }
                    router.go(to: step)
                }
            } else {
                Spacer()
                    .frame(height: 72)
            }
        }
    }
}

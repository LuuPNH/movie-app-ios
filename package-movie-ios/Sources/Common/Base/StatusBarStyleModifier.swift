//
//  File.swift
//  
//
//  Created by ExeLab on 10/6/22.
//

import SwiftUI

struct StatusBarStyleModifier: ViewModifier {
    let color: Color
    let hidden: Bool

    func body(content: Content) -> some View {
        ZStack {
            // View inserted behind the status bar
            VStack {
                GeometryReader { geo in
                    color
                        .frame(height: geo.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)

                    Spacer()
                }
            }

            content
        }
        .statusBar(hidden: hidden)
    }
}

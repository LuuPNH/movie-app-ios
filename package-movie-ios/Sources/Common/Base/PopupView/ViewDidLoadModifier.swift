//
//  SwiftUIView.swift
//  
//
//  Created by ExeLab on 9/26/22.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)

    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action()
                }
            }
    }
}

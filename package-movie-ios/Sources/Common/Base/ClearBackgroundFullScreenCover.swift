//
//  View++.swift
//
//
//  Created by Luu Phan on 09/05/2023.
//

import SwiftUI

struct ClearBackgroundFullScreenCover: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

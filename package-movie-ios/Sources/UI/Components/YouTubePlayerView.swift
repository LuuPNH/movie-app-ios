//
//  YouTubePlayerView.swift
//  
//
//  Created by Hải Lưu on 26/05/2023.
//

import Foundation
import WebKit
import SwiftUI

struct YouTubeView: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoId)?controls=1") else { return }
        uiView.load(URLRequest(url: demoURL))
    }
}

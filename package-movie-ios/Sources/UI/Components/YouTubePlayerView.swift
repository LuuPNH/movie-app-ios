//
//  YouTubePlayerView.swift
//  
//
//  Created by Hải Lưu on 26/05/2023.
//

import Foundation
import WebKit
import SwiftUI
import Domain

struct YouTubeView: UIViewRepresentable {
    let videoKey: String
    
    init(videoId: String) {
        Logger.i("++ YouTubeView init: \(videoId)")
        self.videoKey = videoId
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
//        https://www.youtube.com/embed/1w90tQTzJz8?controls=1
        guard let demoURL = URL(string: "https://www.youtube.com/embed/\(videoKey)?controls=1") else { return }
        uiView.load(URLRequest(url: demoURL))
    }
}

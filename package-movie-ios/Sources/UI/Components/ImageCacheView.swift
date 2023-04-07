//
//  ImageCacheView.swift
//  
//
//  Created by Luu Phan on 06/04/2023.
//

import SwiftUI
import Resources

fileprivate enum StatusLoadImage {
    case isLoading
    case error(Image)
    case success(Image)
}
public struct ImageCacheView<Content, Placeholder> : View where Content : View, Placeholder : View{
    
    @EnvironmentObject var imageCache: ImageCache
    @Environment(\.theme) var theme: AppTheme
    @ViewBuilder var content: (Image) -> Content
    @ViewBuilder var placeholder: () -> Placeholder
    
    
    var url: String
    
    @State private var statusLoadImage: StatusLoadImage = .isLoading
    
    public init(url: String, content: @escaping (Image) -> Content, placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        buildBody()
            .onAppear {
                loadImageFromNetwork(url: URL(string: url))
            }
    }
    
    @ViewBuilder
    func buildBody() -> some View {
        switch statusLoadImage {
        case .isLoading:
            placeholder()
        case let .error(img):
            content(img)
        case let .success(img):
            content(img)
        }
    }
    
    private func loadImageFromNetwork(url: URL?) {
        guard let url = url else { return }
        if let imageData = imageCache.get(key: self.url) {
            statusLoadImage = .success(Image(uiImage: imageData))
        } else {
            statusLoadImage = .isLoading
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data, let imageData = UIImage(data: data) {
                    //Convert image data to UIImage
                    let image = Image(uiImage: imageData)
                    
                    //Save image data to cache
                    imageCache.set(key: self.url, image: imageData)
                    statusLoadImage = .success(image)
                }
                if error != nil {
                    statusLoadImage = .error(Image(systemName: "x.circle"))
                }
            }.resume()
        }
    }
}

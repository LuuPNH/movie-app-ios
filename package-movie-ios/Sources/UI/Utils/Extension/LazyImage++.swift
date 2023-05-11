//
//  LazyImage++.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import Foundation
import NukeUI
import SwiftUI

public struct LazyImageCustom: View {
    
    let url: URL?
    
    public init(url: String?) {
        if url == nil || url!.isEmpty {
            self.url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Error.svg/2198px-Error.svg.png")
        } else {
            self.url = URL(string: url!)
        }
    }
    
    public var body: some View {
        LazyImage(source: ImageRequest(url: url)) { state in
            if let image = state.image {
                image
            } else if state.error != nil {
                Image(systemName: "x.circle")
            } else {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
        }
    }
}

//
//  ShimmerView.swift
//  Scrollable Tab View
//
//  Created by ExeLab on 8/17/22.
//

import Foundation
import SwiftUI

public struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0

    var duration = 1.5
    var bounce = false

    public func body(content: Content) -> some View {
        content
            .modifier(AnimatedMask(phase: phase)
                .animation(
                    Animation.linear(duration: duration)
                        .repeatForever(autoreverses: bounce)
                )
            )
            .onAppear { phase = 0.8 }
    }

    struct AnimatedMask: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(
                    GradientMask(phase: phase)
                        .scaleEffect(3)
                )
        }
    }

    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.red
        let edgeColor = Color.red.opacity(0.3)

        var body: some View {
            LinearGradient(gradient:
                            Gradient(stops: [
                                .init(color: edgeColor, location: phase),
                                .init(color: centerColor, location: phase + 0.1),
                                .init(color: edgeColor, location: phase + 0.2)
                            ]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing
            )
        }
    }
}

#if DEBUG
struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("SwiftUI Shimmer")
            if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                Text("SwiftUI Shimmer").preferredColorScheme(.light)
                Text("SwiftUI Shimmer").preferredColorScheme(.dark)
                VStack(alignment: .leading) {
                    Text("Loading...").font(.title)
                    Text(String(repeating: "Shimmer", count: 12))
                        .redacted(reason: .placeholder)
                }.frame(maxWidth: 200)
            }
        }
        .padding()
        .shimmering()
        .previewLayout(.sizeThatFits)
    }
}
#endif

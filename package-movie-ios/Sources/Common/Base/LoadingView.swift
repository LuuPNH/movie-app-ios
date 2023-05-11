//
//  SwiftUIView.swift
//  
//
//  Created by ExeLab on 8/25/22.
//

import SwiftUI

struct LoadingView: View {
    let heightPerItem: CGFloat = 140

    let fillColor = Color.gray.opacity(0.3)

    var widthPerItem: CGFloat {
        return UIScreen.main.bounds.width - 20
    }

    var itemNumber: Int {
        return Int(UIScreen.main.bounds.height / heightPerItem) + 2
    }

    var rectangleWidth: CGFloat {
        // left: 20, Capsule: 30, left: 20, distance with capsule: 10
        return widthPerItem - 20 - 30 - 10
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(0...itemNumber, id: \.self) { _ in
                VStack(alignment: .center, spacing: 15) {
                    HStack(alignment: .center, spacing: 10) {
                        Capsule(style: .circular)
                            .fill(fillColor)
                            .frame(width: 30, height: 30)
                            .padding(.leading, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Rectangle()
                                .fill(fillColor)
                                .frame(height: 5)
                                .matchWidth()

                            Rectangle()
                                .fill(fillColor)
                                .frame(width: rectangleWidth / 2, height: 5)
                        }
                        .padding(.trailing, 20)
                        .frame(width: rectangleWidth)
                    }
                    .shimmering()
                    .frame(width: widthPerItem, height: 30)
                    .padding(.top)

                    Rectangle()
                        .fill(fillColor)
                        .padding(.horizontal, 20)
                        .frame(height: 5)
                        .matchWidth()
                        .shimmering()

                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
                .padding(.top, 10)
                .frame(width: widthPerItem, height: heightPerItem)
            }
        }
        .padding(.top)
        .matchParent()
        .background(Color.clear)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .background(Color.green)
    }
}

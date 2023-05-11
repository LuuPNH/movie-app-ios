//
//  BottomSheetContent.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import SwiftUI

struct BottomSheetContent<Content>: View where Content: View {
    @Binding var isPresented: Bool
    var height: CGFloat
    var limitRatio: CGFloat
    let content: () -> Content
    var dragToDismiss = true

    @State var transition: CGSize = .zero
    @State var offsetChangeCount: Int32 = 0

    init(
        isPresented: Binding<Bool>,
        height: CGFloat,
        dragToDismiss: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self._isPresented = isPresented
        self.dragToDismiss = dragToDismiss
        self.height = height
        self.limitRatio = 0.5
    }

    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black
                .opacity(0.3 - min(transition.height / height, 0.3))
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    isPresented.toggle()
                }

            content()
                .matchWidth()
                .frame(height: height)
                .offset(y: transition.height)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            offsetChangeCount += 1
                            if offsetChangeCount > 1 {
                                if value.translation.height > 0.0 {
                                    transition = value.translation
                                } else {
                                    transition = .zero
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if offsetChangeCount == 1 {
                                        offsetChangeCount = 0
                                    }
                                }
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if transition.height > height * limitRatio {
                                    withAnimation {
                                        isPresented.toggle()
                                    }
                                } else {
                                    transition = .zero
                                }
                                offsetChangeCount = 0
                            }
                        },
                    including: dragToDismiss ? .all : .subviews
                )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomSheetContentV2<Content>: View where Content: View {
    @Binding var isPresented: Bool
    var sizes: [SizeBottomSheet] = []
    var dragToDismiss = true
    var limitRatio: CGFloat
    let content: () -> Content

    @State var transition: CGSize = .zero
    @State var countChange: UInt32 = 0
    @State var currentSizeIndex = 1
    private var minimumHeight: CGFloat = 100
    private var maximumHeight: CGFloat = SizeBottomSheet.large.height
    @State var showView = false
    private var backGroundColor: Color
    @Binding var isShowMaxHeight: Bool


    init(
        isPresented: Binding<Bool>,
        sizes: [SizeBottomSheet],
        dragToDismiss: Bool = true,
        isShowMaxHeight: Binding<Bool>,
        backGroundColor: Color,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self._isPresented = isPresented
        self.dragToDismiss = dragToDismiss
        self.limitRatio = 3 / 4
        self.backGroundColor = backGroundColor
        self._isShowMaxHeight = isShowMaxHeight
        self.sizes = self.validSizes(sizes)

        if isShowMaxHeight.wrappedValue == true {
            self._currentSizeIndex = State(initialValue: self.sizes.count - 1)
        }
    }

    var maxHeight: CGFloat {
        sizes[sizes.count - 1].height
    }

    func validSizes(_ sizes: [SizeBottomSheet]) -> [SizeBottomSheet] {
        var validSizes = sizes.filter { $0.height >= minimumHeight && $0.height <= maximumHeight }
        if validSizes.isEmpty {
            validSizes.insert(.medium, at: 0)
        }
        validSizes = validSizes.sorted { $0.height < $1.height }
        validSizes.insert(.height(0), at: 0)
        return validSizes
    }

    var body: some View {
        ZStack (alignment: .bottom) {
            if showView {
                self.backGroundColor
                    .opacity(currentSizeIndex == 0 ? 0 : 0.3 * (1.0 - transition.height / maxHeight))
                    .transition(.opacity)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        withAnimation {
                            currentSizeIndex = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isPresented.toggle()
                            }
                        }
                    }

                content()
                    .transition(.move(edge: .bottom))
                    .frame(height: maxHeight)
                    .offset(y: maxHeight - sizes[currentSizeIndex].height + transition.height)
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                countChange += 1

                                if countChange > 1 {
                                    let offset = value.translation.height
                                    let newOffset = maxHeight - sizes[currentSizeIndex].height + offset

                                    if newOffset > 0 {
                                        transition = value.translation
                                        if isShowMaxHeight == true,
                                           transition.height > 0 { // pull down + maximumheight
                                            withAnimation {
                                                isShowMaxHeight = false
                                            }
                                        } else if isShowMaxHeight == false,
                                                  transition.height < 0,
                                                  currentSizeIndex == sizes.count - 2 { // pull up + close to maximum height
                                            withAnimation {
                                                isShowMaxHeight = true
                                            }
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        if countChange == 1 {
                                            countChange = 0
                                        }
                                    }
                                }
                            }
                            .onEnded { value in
                                    let newHeight = sizes[currentSizeIndex].height - transition.height
                                    let index = getIndexRange(newHeight: newHeight)
                                    if index >= 0 {
                                        withAnimation(.spring()) {
                                            currentSizeIndex = index
                                            withAnimation {
                                                isShowMaxHeight = currentSizeIndex == sizes.count - 1
                                            }

                                            transition = .zero
                                        }
                                    }

                                    if index == 0 {
                                        withAnimation {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                isPresented.toggle()
                                            }
                                        }
                                    }
                                    countChange = 0
                            },
                        including: dragToDismiss ? .all : .subviews
                    )
                    .onDisappear {
                        currentSizeIndex = 1
                    }
            }
        }
//        .edgesIgnoringSafeArea(.bottom)
        .animation(.default, value: showView)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showView = true
            }
        }
    }

    func getIndexRange(newHeight: CGFloat) -> Int {
        guard newHeight >= 0 else { return 0 }
        for i in 0..<(sizes.count - 1) {
            let aboveIndex = i + 1
            let belowIndex = i
            let aboveHeight = sizes[aboveIndex].height
            let belowHeight = sizes[belowIndex].height

            if newHeight >= belowHeight, newHeight < aboveHeight {
                if belowIndex >= currentSizeIndex { // drag up
                    return aboveIndex
                } else if aboveIndex <= currentSizeIndex { // drag down
                    if (newHeight - belowHeight) > (aboveHeight - belowHeight) * limitRatio {
                        return aboveIndex
                    }
                    return belowIndex
                }
            }
        }
        return -1
    }
}

public enum SizeBottomSheet: Equatable {
    case medium
    case large
    case height(CGFloat)

    var height: CGFloat {
        switch self {
        case .large:
            return UIScreen.main.bounds.height - AppConstants.safeAreaInsets.top - 20
        case .medium:
            return SizeBottomSheet.large.height / 2
        case let .height(fixed):
            return fixed
        }
    }
}


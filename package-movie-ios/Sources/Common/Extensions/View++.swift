//
//  View++.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import SwiftUI
import Resources

// MARK: Navigation and present
public extension View {
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }

    func navigation<Destination: View>(
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            self
        }
    }

    func navigation<Model, Destination: View>(
        model: Binding<Model?>,
        @ViewBuilder destination: (Model) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { model.wrappedValue != nil },
            set: { value in
                if !value {
                    model.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            model.wrappedValue.map(destination)
        }
    }

    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(isActive: isActive, destination: {
                isActive.wrappedValue ? destination() : nil
            }, label: {
                EmptyView()
            })
        )
    }

    func sheet<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        sheet(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }

    func sheet<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model, Binding<Bool>) -> Content
    ) -> some View {
        let isPresented = model.asBool()
        return sheet(isPresented: isPresented) {
            model.wrappedValue.map {
                content($0, isPresented)
            }
        }
    }

    func fullScreenCover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        fullScreenCover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }

    func fullScreenCover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model, Binding<Bool>) -> Content
    ) -> some View {
        let isPresented = model.asBool()
        return fullScreenCover(isPresented: isPresented) {
            model.wrappedValue.map {
                content($0, isPresented)
            }
        }
    }

    func popover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model) -> Content
    ) -> some View {
        popover(item: model.objectIdentifiable()) { _ in
            model.wrappedValue.map(content)
        }
    }

    func popover<Model, Content: View>(
        model: Binding<Model?>,
        @ViewBuilder content: @escaping (Model, Binding<Bool>) -> Content
    ) -> some View {
        let isPresented = model.asBool()
        return popover(isPresented: isPresented) {
            model.wrappedValue.map {
                content($0, isPresented)
            }
        }
    }

    func handleIsPresented(
        _ isPresented: Binding<Bool>,
        onActive: @escaping (Binding<Bool>) -> Void,
        onInactive: @escaping () -> Void
    ) -> some View {
        onAppear {
            onActive(isPresented)
        }
        .onDisappear(perform: onInactive)
    }
}

// MARK: Others
public extension View {
    func hideNavigationBar(_ isHidden: Bool = true, withBackButton: Bool = true) -> some View {
        navigationBarTitle("") // this must be empty
            .navigationBarHidden(isHidden)
            .navigationBarBackButtonHidden(withBackButton)
    }

    func matchParent() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    func matchWidth() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity
        )
    }

    func matchHeight() -> some View {
        frame(
            minHeight: 0,
            maxHeight: .infinity
        )
    }

    @ViewBuilder
    func isHidden(_ hidden: Bool = true) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }

    @ViewBuilder
    func remove(_ remove: Bool = true) -> some View {
        if !remove {
            self
        }
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    func cornerRadiusBorderClipped(
        _ radius: CGFloat,
        style: Color = Color.black,
        lineWidth: CGFloat = 0
    ) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(style, lineWidth: lineWidth)
        )
        .clipShape(RoundedRectangle(cornerRadius: radius))
    }

    @ViewBuilder
    func bottomSheetFullScreen<Content>(
        isPresented: Binding<Bool>,
        dragToDismiss: Bool = true,
        height: CGFloat,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.fullScreenCover(isPresented: isPresented) {
            BottomSheetContent(
                isPresented: isPresented,
                height: height,
                dragToDismiss: dragToDismiss,
                content: content)
            .transition(.move(edge: .bottom))
            .background(ClearBackgroundFullScreenCover())
        }
    }

    @ViewBuilder
    func bottomSheetFullScreen<Content>(
        isPresented: Binding<Bool>,
        dragToDismiss: Bool = true,
        heights: [SizeBottomSheet],
        backGroundColor: Color = Color.clear,
        isShowMaxHeight: Binding<Bool> = .constant(false),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.fullScreenCover(isPresented: isPresented) {
            BottomSheetContentV2(
                isPresented: isPresented,
                sizes: heights,
                dragToDismiss: dragToDismiss,
                isShowMaxHeight: isShowMaxHeight,
                backGroundColor: backGroundColor,
                content: content)
                .transition(.move(edge: .bottom))
                .background(ClearBackgroundFullScreenCover())
        }
    }

    @ViewBuilder
    func bottomSheet<Content>(
        isPresented: Binding<Bool>,
        dragToDismiss: Bool = true,
        heights: [SizeBottomSheet],
        backGroundColor: Color = Color.clear,
        isShowMaxHeight: Binding<Bool> = .constant(false),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        self.overlay(
            applyViewIf(condition: isPresented.wrappedValue) {
                BottomSheetContentV2(
                   isPresented: isPresented,
                   sizes: heights,
                   dragToDismiss: dragToDismiss,
                   isShowMaxHeight: isShowMaxHeight,
                   backGroundColor: backGroundColor,
                   content: content)
                .transition(.move(edge: .bottom))
            }
        )
    }

    func onTapFullContent(_ action: @escaping () -> Void) -> some View {
        contentShape(Rectangle())
            .onTapGesture {
                action()
            }
    }

    @ViewBuilder
    func shimmering(
        active: Bool = true,
        duration: Double = 1.5,
        bounce: Bool = false
    ) -> some View {
        if active {
            modifier(Shimmer(duration: duration, bounce: bounce))
        } else {
            self
        }
    }

    @ViewBuilder
    func shimmeringWithRedacted(_ active: Bool = true) -> some View {
        self
            .redacted(reason: active ? .placeholder : [])
            .shimmering(active: active)
    }

    @ViewBuilder
    func loading(_ loading: Bool = true) -> some View {
        if loading {
            LoadingView()
        } else {
            self
        }
    }

    func statusBarStyle(color: Color = .blue, hidden: Bool = false) -> some View {
        self.modifier(StatusBarStyleModifier(color: color, hidden: hidden))
    }

    @ViewBuilder
    func applyViewIf<Content>(
        condition: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        if condition {
            content()
        } else {
            Color.clear
        }
    }


    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }

    @ViewBuilder
    func hideScrollContentBackground() -> some View {
        if #available(iOS 16.0, *) {
            scrollContentBackground(.hidden)
        } else {
            self
        }
    }

    @ViewBuilder
    func loading(isPresented: Binding<Bool>, theme: AppTheme = .light) -> some View {
        popup(
            isPresented: isPresented,
            closeOnTap: false,
            closeOnTapOutside: false,
            backgroundColor: theme.blackShades.opacity(0.3)
        ) {
            ProgressView()
                .scaleEffect(2)
                .padding(24)
                .background(theme.whiteShades)
                .cornerRadius(8)
        }
    }

    @ViewBuilder
    func confirmDialog<Content: View>(
        isPresented: Binding<Bool>,
        backgound: Color,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        popup(
            isPresented: isPresented,
            type: .toast,
            position: .bottom,
            dragToDismiss: false,
            closeOnTapOutside: false,
            backgroundColor: backgound,
            view: content
        )
    }
}


// MARK: swipe back gesture
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

// MARK: - ViewDidLoad
extension View {
    public func onViewDidLoad(perform action: @escaping (() -> Void)) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}


////
////  EkycContainerView.swift
////  SmartManager
////
////  Created by teq-macm116g-01 on 15/02/2023.
////
//
//import SwiftUI
//import Resources
//import Common
//
//enum EkycContainerStep: Step {
//    case closeEkyc
//}
//
//struct EkycContainerView: View {
//    let cardType: DocumentType
//    @State var ekycFlow: EkycFlow = .intro
//    @State var isNextTransition = false
//
//    @SwiftUI.Environment(\.theme) var theme: AppTheme
//    @SwiftUI.EnvironmentObject var router: Router<EkycContainerStep>
//
//    @StateObject var orverViewStep = OrverViewStep.router()
//    @StateObject var introStep = IntroStep.router()
//    @StateObject var confirmStep = ConfirmStep.router()
//
//    @State var title = ""
//
//    var body: some View {
//        VStack {
//            switch ekycFlow {
//            case .intro:
//                EkycFlowOverView(cardType: cardType)
//                    .environmentObject(orverViewStep)
//                    .onReceive(orverViewStep.stream) { step in
//                        switch step {
//                        case .start:
//                            goEkycStep(isNext: true)
//                        case .switchIdentityVerification:
//                            closeEkyc()
//                        }
//                    }
//                    .transition(.asymmetric(
//                        insertion: .opacity,
//                        removal: .move(edge: .leading)
//                    ))
//            case let .step(ekycStep, preview):
//                if preview {
//                    ConfirmView(ekycStep: ekycStep, cardType: cardType)
//                        .environmentObject(confirmStep)
//                        .onReceive(confirmStep.stream) { step in
//                            switch step {
//                            case .cancel:
//                                goEkycStep(isNext: false)
//                            case .submit:
//                                goEkycStep(isNext: true)
//                            case .onSwitchIdentityVerification:
//                                closeEkyc()
//                            }
//                        }
//                        .transition(.asymmetric(
//                            insertion: .move(edge: isNextTransition
//                                             ? .trailing
//                                             : .leading),
//                            removal: .move(edge: isNextTransition
//                                           ? .leading
//                                           : .trailing)
//                        ))
//                } else {
//                    IntroStepView(ekycStep: ekycStep, cardType: cardType)
//                        .environmentObject(introStep)
//                        .onReceive(introStep.stream, perform: handleIntroStep)
//                        .transition(.asymmetric(
//                            insertion: .move(edge: isNextTransition
//                                             ? .trailing
//                                             : .leading),
//                            removal: .move(edge: isNextTransition
//                                           ? .leading
//                                           : .trailing)
//                        ))
//                }
//            }
//            Spacer()
//        }
//        .onChange(of: ekycFlow) { step in
//            title = getTitle(step: step)
//        }
//        .onAppear {
//            title = getTitle(step: ekycFlow)
//        }
//    }
//
//    func getTitle(step: EkycFlow) -> String {
//return ""
//    }
//
//    func goEkycStep(isNext: Bool) {
//        isNextTransition = isNext
//        withAnimation {
//            ekycFlow = isNext ? ekycFlow.next : ekycFlow.prev
//        }
//    }
//
//    func closeEkyc() {
//        router.go(to: .closeEkyc)
//    }
//
//
//    func handleIntroStep(_ step: IntroStep) {
//        switch step {
//        case .startEkyc:
//            goEkycStep(isNext: true)
//        case .switchIdentityVerification:
//            router.go(to: .closeEkyc)
//        }
//    }
//}

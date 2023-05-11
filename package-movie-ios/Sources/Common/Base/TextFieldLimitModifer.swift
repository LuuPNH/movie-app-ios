//
//  SwiftUIView.swift
//  
//
//  Created by teq-macm116g-01 on 14/10/2022.
//

import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: $value.wrappedValue) {
                value = String($0.prefix(length))
            }
    }
}

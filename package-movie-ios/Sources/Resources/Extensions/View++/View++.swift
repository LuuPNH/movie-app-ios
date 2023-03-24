//
//  View++.swift
//  
//
//  Created by Luu Phan on 06/03/2023.
//

import SwiftUI

public extension View {
    public func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

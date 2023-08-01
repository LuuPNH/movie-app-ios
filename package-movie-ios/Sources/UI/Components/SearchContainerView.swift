//
//  SearchContainerView.swift
//  
//
//  Created by Luu Phan on 22/03/2023.
//

import SwiftUI
import Resources

public struct SearchContainerView: View {
    
    public init(_ searchKey: Binding<String>) {
        self._searchKey = searchKey
    }
    
    @Environment(\.theme) var theme: AppTheme
    
    @Binding private var searchKey: String
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(theme.grey92929D)
                .padding(.leading, 24)
            TextField(
                "User name (email address)",
                text: $searchKey
            ) .placeholder(when: searchKey.isEmpty) {
                Text("Type here...")
            }
            .foregroundColor(theme.grey92929D)
            .padding(.leading, 4)
            .frame(maxWidth: .infinity)
            if !searchKey.isEmpty {
                Divider()
                    .background(theme.grey92929D)
                    .frame(height: 20)
                    .padding(.trailing, 4)
                Image(systemName: "delete.left")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundColor(theme.grey92929D)
                    .padding(.trailing, 24)
                    .onTapGesture {
                        searchKey = ""
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(theme.blue252836)
        .cornerRadius(30)
        .padding(.all, 16)
        
    }
}

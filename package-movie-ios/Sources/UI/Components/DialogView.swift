//
//  SwiftUIView.swift
//  
//
//  Created by Luu Phan on 28/04/2023.
//

import SwiftUI
import Resources

struct DialogView: View {
    
    @SwiftUI.Environment(\.theme) var theme: AppTheme
    
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
                .frame(height: 16)
            AppImages.error()
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(theme.blackShades)
                .padding(.leading, 8)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                .frame(width: 64, height: 32)
                .background(theme.primary)
                .cornerRadius(15)
                .overlay {
                    Text("OK")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(theme.whiteShades)
                        .multilineTextAlignment(.center)
                }
            
            Spacer()
                .frame(height: 8)
            
        }
        .frame(width: UIScreen.screenWidth / 1.5)
        .background(theme.whiteShades)
        .cornerRadius(15)
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(text: "DialogView_Previews")
    }
}

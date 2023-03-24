//
//  HomeHeaderView.swift
//  
//
//  Created by Luu Phan on 22/03/2023.
//

import SwiftUI
import Resources

struct HomeHeaderView: View {
    
    @Environment(\.theme) var theme: AppTheme
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Sam_Worthington_4%2C_2013.jpg/640px-Sam_Worthington_4%2C_2013.jpg")){
                image in
                image.resizable()
            } placeholder: {
                theme.blue242634
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.red)
            .clipShape(Circle())
            .padding(.leading, 8)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Hello, Smith")
                    .foregroundColor(theme.whiteShades)
                    .font(.title)
                    .fontWeight(.bold)
                Text("Let’s stream your favorite movie")
                    .foregroundColor(theme.grey)
                    .font(.caption)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 4)
            Image(systemName: "heart.fill")
            
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
                .background(theme.blue242634)
                .cornerRadius(15)
                .padding(.trailing, 8)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(theme.primary)
        .cornerRadius(15)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}

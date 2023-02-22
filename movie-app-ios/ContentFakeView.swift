//
//  ContentFakeView.swift
//  movie-app-ios
//
//  Created by Luu Phan on 13/01/2023.
//

import SwiftUI

struct ContentFakeView: View {
    
    @State var selectTab:Tab = .tab1
    
    enum Tab {
        case tab1
        case tab2
        case tab3
    }
    
    var body: some View {
        TabView(selection: $selectTab) {
            FakeView1()
                .tag(Tab.tab1)
                .tabItem{
                    Label("Tab 1", systemImage: "star")
                }
            
            FakeView2()
                .tag(Tab.tab2)
                .tabItem {
                    Label("Tab 2", systemImage: "star")
                        .foregroundColor(.red)
                }
            
            FakeView3()
                .tag(Tab.tab3)
                .tabItem{
                    Label("Tab 3", systemImage: "star")
                }
        }
    }
}

struct ContentFakeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentFakeView()
    }
}





struct FakeView1: View {
    
    var body: some View {
        Text("Screen tab 1")
    }
}

struct FakeView2: View {
    
    var body: some View {
        NavigationView {
            NavigationLink {
                DetailScreen(title: "FakeView2")
            } label: {
                VStack {
                    Text("Screen FakeView 2")
                    
                    Button(action: goDetail) {
                        Text("Go detail")
                    }
                    .foregroundColor(.blue)
                    .buttonStyle(.bordered)
                    .background(.gray)
                    .cornerRadius(10)
                }
            }
            
        }
        .navigationTitle("Title navigation screen tab 2")
    }
    
    func goDetail() {
        print("go detail screen fake 2")
    }
    
}

struct FakeView3: View {
    
    var body: some View {
        Text("Screen tab 3")
    }
}

struct DetailScreen: View {
    var title: String
    var body: some View {
        Text("Detail \(title)")
    }
}

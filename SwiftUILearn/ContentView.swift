//
//  ContentView.swift
//  SwiftUILearn
//
//  Created by QinY on 17/7/2024.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        
        TabView{
            NavigationStack {
                HomeView()
            }.tabItem {
                Label("Home", systemImage: "1.circle")
                    .font(.headline)
                    
            }
            NavigationStack {
                TestView(title: "testView")
            }.tabItem {
                Label("Test", systemImage: "2.circle")
                    .font(.headline)
                    
            }
        }
       
    }
}

#Preview {
    ContentView()
}

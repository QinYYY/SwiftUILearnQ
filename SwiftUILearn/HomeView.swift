//
//  HomeView.swift
//  SwiftUILearn
//
//  Created by QinY on 17/7/2024.
//

import SwiftUI

struct HomeView: View {
    var items = ["CupcakeCorner","Bookworm","SwiftDataView","BucketList","testView"]
    var body: some View {
        
        NavigationStack {
            List(items,id: \.self){item in
                
                NavigationLink(item) {
                    if item == "CupcakeCorner" {
                        CupcakeCornerView(title: item)
                    }
                    
                    if item == "Bookworm" {
                        BookwormView(title: item)
                    }
                    if item == "SwiftDataView" {
                        SwiftDataProject()
                    }
                    if item == "BucketList" {
                        BucketListView()
                    }
                    
                    
                    
            
                    if item == "testView" {
                        TestView(title: item)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}

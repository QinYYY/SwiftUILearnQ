//
//  SwiftUILearnApp.swift
//  SwiftUILearn
//
//  Created by QinY on 17/7/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftUILearnApp: App {
    
    let modelContainer: ModelContainer

        init() {
            do {
                modelContainer = try ModelContainer(for: Book.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(modelContainer)
        .modelContainer(for: Book.self)
    }
}

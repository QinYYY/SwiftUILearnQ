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
                
                let config1 = ModelConfiguration(for: Book.self)
                let config2 = ModelConfiguration(for: SwiftDataUser.self,isStoredInMemoryOnly: true)
                modelContainer = try ModelContainer(for: Book.self,SwiftDataUser.self,configurations: config1,config2)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
//    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
//        .modelContainer(for: Book.self)
//        .modelContainer(for:SwiftDataUser.self)
    }
}

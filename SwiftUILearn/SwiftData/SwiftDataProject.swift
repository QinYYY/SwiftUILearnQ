//
//  SwiftDataProject.swift
//  SwiftUILearn
//
//  Created by QinY on 23/7/2024.
//

import SwiftUI
import SwiftData
struct SwiftDataProject: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort:\SwiftDataUser.name) var users:[SwiftDataUser]
    
    
    
    @State private var path = [SwiftDataUser]()
    
    var body: some View {
        NavigationStack(path: $path){
            List(users){user in
                NavigationLink(value: user){
                    Text(user.name)
                }
                
            }
            .navigationTitle("Users")
            .navigationDestination(for: SwiftDataUser.self) { user in
                SwiftDataEditUserView(SDUser: user)
            }
            .toolbar{
                Button("Add User",systemImage: "plus"){
                    let user = SwiftDataUser(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
                Button("delete",systemImage: "delete"){
                    
                }
                
                
            }
        }
    }
}

#Preview {
    SwiftDataProject()
}

//
//  SwiftDataEditUserView.swift
//  SwiftUILearn
//
//  Created by QinY on 23/7/2024.
//

import SwiftUI
import SwiftData

struct SwiftDataEditUserView: View {
    @Bindable var SDUser:SwiftDataUser
    
    
    
    
    var body: some View {
        Form {
            
            TextField("Name",text: $SDUser.name)
            TextField("City",text: $SDUser.city)
            DatePicker("Join Date",selection: $SDUser.joinDate)
            
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: SwiftDataUser.self, configurations: config)
        
        let user = SwiftDataUser(name: "", city: "", joinDate: .now)
        return SwiftDataEditUserView(SDUser: user)
            .modelContainer(container)
    } catch {
        
        return Text("Failed to create container:\(error.localizedDescription)")
    }
    
    
}

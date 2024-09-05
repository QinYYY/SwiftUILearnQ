//
//  EditView.swift
//  SwiftUILearn
//
//  Created by QinY on 3/9/2024.
//

import SwiftUI
enum LoadingState {
    case loading,success,failed
}

struct LoadingView:View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView:View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView:View {
    var body: some View {
        Text("Failed.")
    }
}


struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location:Location
    @State private var name:String
    @State private var description:String
    
    var onSave:(Location) -> Void
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name",text: $name)
                    TextField("Description",text: $description)
                }
                
                Section {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages,id:\.pageid) {page in
                            Text(page.title)
                                .font(.headline)
                            
                            
                        }
                    }
                }
                
                Section {
                    Button ("save") {
                        var newLoaction = location
                        newLoaction.name = name
                        newLoaction.description = description
                        onSave(newLoaction)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Place detail")
            .toolbar {
                Button("save") {
                    dismiss()
                }
            }
        }
    }
    init(location:Location,onSave:@escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    
}

#Preview {
    EditView(location: Location(id: UUID(), name: "", description: "", latitude: 0.00, longitude: 0.00)) { location in
        
    }
}

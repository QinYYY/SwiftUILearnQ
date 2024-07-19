//
//  BookwormView.swift
//  SwiftUILearn
//
//  Created by QinY on 18/7/2024.
//

import SwiftUI
import SwiftData

struct BookwormView: View {
    let title:String
    
    @AppStorage("notes") private var notes = ""
    
    @Query var students:[Student]
    @Query var books:[Book]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(books) { book in
                    
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                                
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                    .font(.system(size: 20))
                                Text("Author:\(book.author)")
                                    .foregroundStyle(book.rating < 3 ? .red : .secondary)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    deleteBooks(at: indexSet)
                })
            }
            .navigationTitle("Bookworm")
            
            .toolbar {
                Button("Add book",systemImage: "plus"){
                    showingAddBookView.toggle()
                }
                Button("edit",systemImage: "pencil"){
                    
                }
            }.sheet(isPresented: $showingAddBookView){
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                
                BookDetailView(book: book)
                
                
            }
        }
    }
    
    func deleteBooks(at offsets:IndexSet){
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
        }
    }
    
}

#Preview {
    BookwormView(title: String())
}
//            List(students){ student in
//
//                Text(student.name)
//
//            }
            
//            .navigationTitle("Classroom")
//            .toolbar {
//                Button("Add") {
//
//                    let firstNames = ["Joli","Oliver","Luna","Ron"]
//                    let lastNames = ["Lovegood","Potter","Weasley","Granger"]
//                    let chosenFirstName = firstNames.randomElement()!
//                    let chosenLastName = lastNames.randomElement()!
//                    print("Name \(chosenFirstName) \(chosenLastName)")
//
//                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
//
//                    modelContext.insert(student)
//
//
//                }
//            }
            
//            TextField("Enter your text",text: $notes,axis: .vertical)
//                .textFieldStyle(.roundedBorder)
//                .navigationTitle("Notes")
//
//                .padding()
//            TextEditor(text: $notes)
//                .navigationTitle(title)
//                .padding()

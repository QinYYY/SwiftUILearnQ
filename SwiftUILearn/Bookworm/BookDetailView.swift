//
//  BookDetailView.swift
//  SwiftUILearn
//
//  Created by QinY on 18/7/2024.
//

import SwiftUI
import SwiftData
struct BookDetailView: View {
    let book:Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    var body: some View {
        
        NavigationStack{
            ScrollView {
                ZStack(alignment:.bottomTrailing) {
                    Image(book.genre)
    //                Image("Horror")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                    
                    Text(book.genre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.background.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x:-5,y:-5)
                    
                }
                
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)
                Text(book.review)
                    .padding()
                RatingView(rating: .constant(book.rating))
                    .font(.largeTitle)
                
            }.navigationTitle(book.title)
                .navigationBarTitleDisplayMode(.inline)
                .scrollBounceBehavior(.basedOnSize)
                .alert("Delete book", isPresented: $showingDeleteAlert) {
                    Button("Delete",role: .destructive,action: deleteBook)
                    Button("Cancel",role: .cancel){
                        
                    }
                }message: {
                    Text("Are you ok?")
                }
                .toolbar{
                    Button("Delete this book",systemImage: "trash"){
                        showingDeleteAlert = true
                    }
                }
        }.onAppear(perform: {
            print("212")
        })
        
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    
    do {
        print("detail")
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Test Genre", review: "Test review", rating: 3)
        print("detail1")
        return BookDetailView(book: example).modelContainer(container)
    } catch {
        print("Failed to create preview \(error.localizedDescription)")
        return Text("Failed to create preview \(error.localizedDescription)")
    }
    
}

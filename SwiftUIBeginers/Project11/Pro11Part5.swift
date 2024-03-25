//
//  Pro11Part5.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftUI
import SwiftData

struct DetailViewPro11: View {
    let book: BookPro11
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing, content: {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.6))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            })
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            
                
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.date, format: .dateTime.month().day().hour().minute())
                
            

            Text(book.review)
                .padding()
            
            RatingViewPro11(rating:.constant(book.rating))
                .font(.largeTitle)
        }
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
            
        } message: {
            Text("Are You Sure")
        }
        .toolbar {
            Button("Delete The Book", systemImage: "trash") {
                showingDeleteAlert.toggle()
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelcontainer = try ModelContainer(for: BookPro11.self, configurations: config)
        let example = BookPro11(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4)

        return DetailViewPro11(book: example)
            .modelContainer(modelcontainer)
    }catch{
        return Text("Failed to create preview: \(error.localizedDescription)")

        
    }
}

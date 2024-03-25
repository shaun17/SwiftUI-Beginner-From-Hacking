//
//  Pro11Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftData
import SwiftUI

@Model
class BookPro11 {
    var id: UUID
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date = Date.now

    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.id = UUID()
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    
}

struct BookViewPro11: View {
    @Environment(\.modelContext) var modelContext
//    @Query(sort: \BookPro11.rating, order: .reverse) var books: [BookPro11]
    @Query(sort: [SortDescriptor(\BookPro11.rating, order: .reverse)]) var books: [BookPro11]
    @State private var showingAddScren = false
    
    
    var body: some View {
        NavigationStack
        {
            Text("Count: \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book") {
                            showingAddScren.toggle()
                        }
                    }
                })
                .sheet(isPresented: $showingAddScren, content: {
                    Pro11Part3()
                })
            
            List{
                ForEach(books){ book in
                    NavigationLink(value: book) {
                        HStack{
                            EmojiRatingViewPro11(rating: book.rating)
                                .font(.largeTitle)
                            VStack{
                                HStack{
                                    Text("\(book.title)")
                                        .font(.headline)
                                        .foregroundColor(book.rating != 1 ? .black : .red)
                                    Text("author : \(book.author)")
                                        .foregroundStyle(.secondary)
                                }
                                Text(book.review)
                                    .font(.subheadline)
                                    
                            }
                        }
                    }
                  
                }
                .onDelete(perform: { indexSet in
                    deleteBooks(at: indexSet)
                })
            }
            .navigationDestination(for: BookPro11.self) { book in
                DetailViewPro11(book: book)
            }
            .toolbar(content: {
                EditButton()
            })
            
        }
    }
    
    func deleteBooks(at offSets: IndexSet){
        for offset in offSets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

struct Pro11Part3: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                    Section("Write a review"){
                        TextEditor(text: $review)
                        RatingViewPro11(rating: $rating)

                        
                    }
                    Section{
                        Button("Save"){
                            let book = BookPro11(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(book)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")

        }
    }
}

#Preview {
    BookViewPro11()
        .modelContainer(for: BookPro11.self)
}

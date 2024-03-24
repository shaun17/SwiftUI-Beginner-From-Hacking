//
//  AddBookViewProject11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/11.
//

import SwiftUI

struct AddBookViewProject11: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    var body: some View {
        NavigationView(content: {
            Form(content: {
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                    
                }
                
                
                Section{
                    TextEditor(text: $review)
                    RatingView_Project11(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section{
                    Button("Save"){
                        let book = Book(context: moc)
                        book.id=UUID()
                        book.title = title
                        book.author = author
                        book.genre  = genre
                        book.review = review
                        book.rating = Int16(rating)
                        try? moc.save()
                        dismiss()
                        
                    }
                }
            })
            .navigationTitle("Add A Book")
            
        })
        
    }
    

}
    

struct AddBookViewProject11_PreView: PreviewProvider {
    
    static var dataController = DataController()

    static var previews: some View{

        AddBookViewProject11()
                .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

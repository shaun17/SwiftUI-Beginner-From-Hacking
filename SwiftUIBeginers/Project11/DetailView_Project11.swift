//
//  DetailView——project1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/12.
//

import CoreData
import SwiftUI

struct DetailView_Project11: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var showingDeleteAlert = false
    var book: Book
    var body: some View {
        ScrollView {
            ZStack {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                Text(book.genre ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5,y: -5)
            }
            .navigationTitle(book.title ?? "Unknow")
            .navigationBarTitleDisplayMode(.inline)
            
            Text(book.author ?? "Unknow")
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            Text(book.genre ?? "No genre")
                .padding()
            
            
            RatingView_Project11(rating: .constant(Int(book.rating)))
                .font(.largeTitle)


        }
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel, action: {})
        }
        .toolbar(content: {
            Button{
                showingDeleteAlert.toggle()
            } label: {
                Label("Delete this book", systemImage: "trash")

            }
        })
        
    }
    
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

struct DetailView_PreView: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var dataController = DataController()

    static var previews: some View {
        
        let book = Book(context: dataController.container.viewContext)
        
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView(content: {
            DetailView_Project11(book: book)
        })
    }
}

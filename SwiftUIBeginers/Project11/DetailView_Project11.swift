//
//  DetailView——project1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/12.
//

import CoreData
import SwiftUI

struct DetailView_Project1: View {
    var book: Book
    var body: some View {
        ScrollView {
            ZStack {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct DetailView_PreView: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView(content: {
            DetailView_Project1(book: book)
        })
    }
}

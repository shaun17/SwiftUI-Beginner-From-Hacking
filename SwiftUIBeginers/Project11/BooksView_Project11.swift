//
//  BooksView_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/11.
//

import SwiftUI

struct BooksView_Project11: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    
    @State private var showAddScren = false
    var body: some View {
        NavigationView(content: {
            Text("Count \(books.count)")
                .navigationTitle("Bookworm")
                .toolbar(content: {
                    ToolbarItem {
                        Button{
                            showAddScren.toggle()
                        }label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                })
                .sheet(isPresented: $showAddScren, content: {
                    AddBookViewProject11()
                })
           
        })
    }
}


struct BookView_PreView: PreviewProvider {
    
    static var dataController = DataController()

    static var previews: some View{
        BooksView_Project11()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

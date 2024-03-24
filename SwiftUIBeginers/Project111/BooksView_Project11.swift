//
//  BooksView_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/11.
//

import SwiftUI

struct BooksView_Project11: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    
    @State private var showAddScren = false
    @State private var editingStaut = false
    var body: some View {
        NavigationView(content: {
            
            List{
                ForEach(books){ book in
                    NavigationLink(destination: DetailView_Project11(book: book), label: {
                        HStack{
                            EmojiRatingView_Project11(rating: book.rating)
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknow")
                                    .font(.headline)
                                Text(book.author ?? "Unknow")
                                    .foregroundStyle(.secondary)
                            }
                            
                        }
                        
                    })
                        
                }
                .onDelete(perform: { indexSet in
                    deletBook(at: indexSet)
                })
                
            }
            .navigationTitle("Bookworm")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                       
                }
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
    
    func deletBook(at offsets: IndexSet) {
        for offset in offsets{
            let book = books[offset]
            moc.delete(book)
            
        }
        try? moc.save()
        
    }
}


struct BookView_PreView: PreviewProvider {
    
    static var dataController = DataController()

    static var previews: some View{

        BooksView_Project11()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

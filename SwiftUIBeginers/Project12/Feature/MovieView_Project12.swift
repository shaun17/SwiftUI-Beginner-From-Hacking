//
//  MovieView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/14.
//

import CoreData
import SwiftUI

struct MovieView_Project12: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>

    @State var showingDeleteAlert = false
    
    var body: some View {
        NavigationView(content: {
            VStack {
                ForEach(movies, id: \.self) {movie in
                    Section {
                        Text(movie.title)
                            .font(.headline)
                            .font(.largeTitle)
                            .bold()
                        Text(movie.director)
                            .padding()
                            .font(.subheadline)
                            
                        
                    }
                }
            }
            .alert("add Book", isPresented: $showingDeleteAlert) {
                Button("Add", role: .destructive, action: addMovie)
                Button("Cancel", role: .cancel, action: {})
            }
            .toolbar(content: {
                Button {
                    showingDeleteAlert.toggle()
                } label: {
                    Label("Delete this book", systemImage: "plus")
                }
            })
            
        })
    }
    
    func addMovie() {
        let movie = Movie(context: moc)
        movie.title = "movie"
        movie.director = "Tom ject"
        movie.year = 2
        
        try? moc.save()
    }
}

struct MovieView_PreView: PreviewProvider {
    static let dataController = DataController()
    static var previews: some View {
        MovieView_Project12()
            .environment(\.managedObjectContext, dataController.container2.viewContext)
    }
}

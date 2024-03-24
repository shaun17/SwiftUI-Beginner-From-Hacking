//
//  MivewListView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//
import CoreData
import SwiftUI

struct MivewListView_Project12: View {
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    var body: some View {
        VStack{
            List {
                ForEach(movies, id: \.self){ movie in
                    Text(movie.title)
                }
            }
        }
    }
}

struct MovieListView_PreView: PreviewProvider{
    static let dataController = DataController()

    static var previews: some View{
        MivewListView_Project12()
            .environment(\.managedObjectContext, dataController.container2.viewContext)
    }
}

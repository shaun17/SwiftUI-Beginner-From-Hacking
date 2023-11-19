//
//  SingerView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//

import CoreData
import SwiftUI

struct SingerView_Project12: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    var body: some View {
        VStack{
            
            FilterView_Project12(filterKey: "lastName", filterVal: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Example"){
                let taylor = Singer(context: moc)
                        taylor.firstName = "Taylor"
                        taylor.lastName = "Swift"

                        let ed = Singer(context: moc)
                        ed.firstName = "Ed"
                        ed.lastName = "Sheeran"

                        let adele = Singer(context: moc)
                        adele.firstName = "Adele"
                        adele.lastName = "Adkins"

                        try? moc.save()
            }
            
            Button("Show A"){
                lastNameFilter = "A"
            }
            Button("Show S"){
                lastNameFilter = "S"
            }
        }
    }
}

struct SingerView_PreView: PreviewProvider{
    static let datacontai = DataController()
    static var previews: some View{
        SingerView_Project12()
            .environment(\.managedObjectContext, datacontai.container2.viewContext)
    }
    
    
}

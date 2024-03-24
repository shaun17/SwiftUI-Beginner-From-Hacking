//
//  ConuntryCandyView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/19.
//

import SwiftUI

struct ConuntryCandyView_Project12: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countrys: FetchedResults<Country>
    var body: some View {
        VStack {
            List {
                ForEach(countrys, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("clean"){
                for obj in moc.registeredObjects {
                    moc.delete(obj)
                }
                try? moc.save()
            }
            
            Button("Add The Example") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingd"

                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? moc.save()
            }
        }
    }
}

struct CountryCandy_PreView:PreviewProvider{
    
    static let dataContain = DataController()
    
    static var previews: some View{
        ConuntryCandyView_Project12()
            .environment(\.managedObjectContext, dataContain.container2.viewContext)
    }
    
    
}

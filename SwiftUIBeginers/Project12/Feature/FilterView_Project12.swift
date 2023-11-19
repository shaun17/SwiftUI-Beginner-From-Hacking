//
//  FilterView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//

import SwiftUI

struct FilterView_Project12: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    var body: some View {
        List{
            ForEach(fetchRequest, id: \.self){ singer in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")

            }
        }
    }
}

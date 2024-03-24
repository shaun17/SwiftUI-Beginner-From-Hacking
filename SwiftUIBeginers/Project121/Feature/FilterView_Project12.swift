//
//  FilterView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//

import CoreData
import SwiftUI

struct FilterView_Project12<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    init(filterKey: String, filterVal:String, @ViewBuilder content: @escaping (T) -> Content ) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: " %K BEGINSWITH %@", filterKey, filterVal))
        self.content = content
    }
    var body: some View {
        List{
            ForEach(fetchRequest, id: \.self){ item in
                self.content(item)
            }
        }
    }
}

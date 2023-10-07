//
//  SwiftUIViewExpress.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/7.
//

import SwiftUI

struct SwiftUIViewExpress: View {
    @StateObject var items = Express()
    @State private var showView = false
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(items.expressItems){ item in
                        HStack{
                            Text("\(item.id)")
                            Text(item.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeItem(indexSet)
                    })
                }
                .navigationTitle("ExpressItem")
                .toolbar(content: {
                    Button{
                        showView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                   
                })
                .sheet(isPresented: $showView, content: {
                    SwiftUIViewAddView(express: items)
                })
            }
        }
    }
    func removeItem(_ offsets: IndexSet){
        items.expressItems.remove(atOffsets: offsets)
    }
}

#Preview {
    SwiftUIViewExpress()
}

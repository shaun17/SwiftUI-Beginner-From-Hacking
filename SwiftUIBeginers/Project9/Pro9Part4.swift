//
//  Pro9Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftUI

struct Pro9Part4: View {
    
    @State private var title = "SwiftUI"

    var body: some View {
//        NavigationStack {
//            List(0..<100){ i in
//                Text("Rows \(i)")
//            }
//            .navigationTitle("Title goes here")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarColorScheme(.light, for: .navigationBar)
//            .toolbar(.hidden, for: .navigationBar)
//        }
        
        NavigationStack{
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItemGroup(placement: .navigation
                                     , content: {
                        Button("Tap1"){
                            print("aaa")
                        }
                        Button("Tap2") {
                            // button action here
                        }
                    })
                    ToolbarItem(placement: .navigation) {
                        Button("Tap me"){
                            print("aaa")
                        }
                       
                    }
                   
                })
        }
    }
}

#Preview {
    Pro9Part4()
}

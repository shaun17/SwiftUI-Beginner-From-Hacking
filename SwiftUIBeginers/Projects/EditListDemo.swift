//
//  EditListDemo.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/19.
//

import SwiftUI

struct EditListDemo: View {
    @State private var demos = ["aa", "bb", "ccc", "ddd", "eee"]
    @State private var selection = Set<String>()
    @State var editMode = EditMode.inactive

    var body: some View {
        
        NavigationStack {
            VStack {
//                List(demos, id: \.self) { demo in
//                    Text(demo)
//                }
                List {
                    ForEach(demos, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: { indexSet in
                        demos.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        demos.move(fromOffsets: indices, toOffset: newOffset)

                    })
                }

//                EditButton()
            }
            .navigationTitle("List Selection")
            .toolbar {
                EditButton()
            }
            .environment(\.editMode, $editMode)

        }
    }
    func removeRows(at offset: IndexSet){
        
    }
}

#Preview {
    EditListDemo()
}

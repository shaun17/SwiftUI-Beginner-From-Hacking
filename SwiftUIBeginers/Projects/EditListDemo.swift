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
    @State private var draggedIndex: Int?


    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(demos.indices, id: \.self) { index in
                        Text(demos[index])
                            .onDrag {
                                self.draggedIndex = index
                                return NSItemProvider(object: String(demos[index]) as NSString)
                            }
                    }
                    .onDelete(perform: { indexSet in
                        demos.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        demos.move(fromOffsets: indices, toOffset: newOffset)
                    })
                }
            }
            .navigationTitle("List Selection")
            .toolbar {
                EditButton()
            }
            .environment(\.editMode, $editMode)
        }
    }
}

#Preview {
    EditListDemo()
}

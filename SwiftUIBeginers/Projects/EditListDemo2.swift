//
//  EditListDemo2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/20.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragToReorderList: View {
    @State private var items = ["苹果", "香蕉", "橙子", "西瓜", "葡萄"]
    @State private var draggedItem: String?
    @State private var target = true

    var body: some View {
        VStack {
            LazyVStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .onDrag {
                            self.draggedItem = item
                            //                        return NSItemProvider(item: nil, typeIdentifier: item)
//                            let nsip = NSItemProvider(object: NSString(string: item))
                            let nsip = NSItemProvider(item: nil, typeIdentifier: String(item.lowercased()))
//                                                    nsip.suggestedName = item
                            //                        print(1111)
                            return nsip
                        }
                        .onDrop(of: [.text], delegate: DropDelegate222(items: $items, currentItem: item, draggedItem: $draggedItem))
                }
            }
        }
    }
}

struct DropDelegate222: DropDelegate {
    @Binding var items: [String]
    let currentItem: String
    @Binding var draggedItem: String?

    func performDrop(info _: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info _: DropInfo) {
        print(draggedItem ?? 2222)
        guard let draggedItem = draggedItem, let fromIndex = items.firstIndex(of: draggedItem), let toIndex = items.firstIndex(of: currentItem) else {
            return
        }
        print(draggedItem)

        if fromIndex != toIndex {
            items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
        }
    }

//    func performDrop(info _: DropInfo) -> Bool {
//        print(draggedItem ?? 2222)
//        guard let draggedItem = draggedItem, let fromIndex = items.firstIndex(of: draggedItem), let toIndex = items.firstIndex(of: currentItem) else {
//            return false
//        }
//        print(draggedItem)
//
//        if fromIndex != toIndex {
//            items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
//        }
//        return true
//    }
}

#Preview {
    DragToReorderList()
}

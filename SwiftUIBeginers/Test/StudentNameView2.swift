//
//  StudentNameView2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/9.
//

import SwiftUI

@Observable
final class Store2 {
    var name = "肥肥"
    var age = 5
    func updateAge() {
        age += 1
    }
}

struct NameView2: View {
    var store: Store2
    var body: some View {
        let _ = print("NameView Update")
        Text(store.name)
    }
}

struct AgeView2: View {
    var store: Store2
    var body: some View {
        let _ = print("AgeView Update")
        Text(store.age, format: .number)
    }
}

struct StudentNameView2: View {
    @State var store = Store2()
    var body: some View {
        VStack {
            NameView2(store: store)
            AgeView2(store: store)

            Button("Change Age") { 
                store.updateAge()
            }

            .font(.title)
        }
    }
}

#Preview {
    StudentNameView2()
}

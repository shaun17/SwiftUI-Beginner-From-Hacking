//
//  StudentNameView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/9.
//

import SwiftUI

final class Store: ObservableObject {
    @Published var name = "肥肥"
    @Published var age = 5
    func updateAge(){
        age += 1
    }
}


struct NameView: View {
    @ObservedObject var store: Store

    var body: some View {
        let _ = print("NameView Update")
        Text(store.name)
    }
}

struct AgeView: View {
    @ObservedObject var store: Store
    var body: some View {
        let _ = print("AgeView Update")
        Text(store.age, format: .number)
    }
}

struct StudentNameView: View {
    @StateObject var store  = Store()
    var body: some View {
        VStack {
            NameView(store: store)
            AgeView(store: store)

            Button("Change Age") { store.updateAge()
            }

            .font(.title)
        }
    }
}

#Preview {
    StudentNameView()
}

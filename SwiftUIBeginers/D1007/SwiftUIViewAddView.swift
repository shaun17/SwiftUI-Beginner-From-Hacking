//
//  SwiftUIViewAddView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/7.
//

import SwiftUI

struct SwiftUIViewAddView: View {
    @ObservedObject var express: Express
    @Environment(\.dismiss) var dissmiss
    @State private var name = ""
    @State private var type = "personal"
    @State private var age = 0
    @State private var types = ["personal","business"]
    
    var body: some View {
        NavigationView(content: {
            
            VStack(content: {
                Form(content: {
                    TextField("name", text: $name)
                    Picker("type", selection: $type) {
                        ForEach(types, id: \.self){
                            Text($0)
                        }
                    }
                    TextField("age", value: $age, format: .number)
                        .keyboardType(.decimalPad)
                })
                   
            })
            .onSubmit {
                
                express.expressItems.append(ExpressItem(name: name, age: age, type: type))
                    dissmiss()
            }
        })
    }
}

#Preview {
    SwiftUIViewAddView(express: Express())
}

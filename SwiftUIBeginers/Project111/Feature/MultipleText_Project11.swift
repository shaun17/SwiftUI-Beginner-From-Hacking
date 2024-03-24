//
//  MultipleText_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/10.
//

import SwiftUI

struct MultipleText_Project11: View {
    @AppStorage("notes") private var note = ""
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                Section {
                    TextEditor(text: $note)
                        .navigationTitle("Notes")
                        .padding()
                }
                Section {
                    TextEditor(text: $note)
                        .navigationTitle("Notes")
                        .padding()
                }
                
            })
        
        })
    }
}

#Preview {
    MultipleText_Project11()
}

//
//  Pro11Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftUI

struct Pro11Part1: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Enter your text", text: $notes, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                    }
                        
                    Section {
                        TextEditor(text: $notes)
                    }
                }
              
                PushButtonPro11(title: "Remember Me", isOn: $rememberMe)
                Text(rememberMe ? "On" : "Off")
                
                Spacer()
            }
            .navigationTitle("Notes")
        }
    }
}

struct PushButtonPro11: View {
    let title: String
    @Binding var isOn: Bool
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(.capsule)
        .shadow(radius: isOn ? 0 : 5)
    }
}

#Preview {
    Pro11Part1()
}

//
//  Pro2Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/11.

// VStack, Image, LinearGradient, and more.

import SwiftUI

struct Pro2Part1: View {
    @State private var showingAlert = false

    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                //                Color.red
                //                Color.blue
                //                LinearGradient(colors: [.white,.black], startPoint: .top, endPoint: .bottom)
                
                //                LinearGradient(stops: [.init(color: .white, location: 0.2),
                //                                       .init(color: .black, location: 0.8)], startPoint: .top, endPoint: .bottom)
                
                //                RadialGradient(colors: [.red,.blue], center: .top, startRadius: 200, endRadius: 500)
                //
                //                AngularGradient(colors: [.yellow,.green], center: .center, angle: .init(degrees: 0))
                
                AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            }
            VStack{
                Text("Your content")
                    .foregroundStyle(.secondary)
                    .padding(50)
                    .background(.ultraThinMaterial)
                
                Button("Button 1") {}
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                
                Button("Button 2", role: .destructive) {}
                    .buttonStyle(.bordered)
                
                Button(action: {}, label: {
                    Text("Button")
                        .padding()
                        .foregroundStyle(.white)
                        .background(LinearGradient(colors: [.pink,.orange], startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                })
                
                Button(action: {}
                       , label: {
                    Label("taptap", systemImage: "pencil")
                        .padding(12)
                        .foregroundStyle(.white)
                        .background(LinearGradient(colors: [.red,.purple], startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    
                })
                
                Button(action: {
                    showingAlert = true
                }, label: {
                   Text("Show Alert")
                        .padding()
                        .foregroundColor(.pink)
                        .background(LinearGradient(colors: [.yellow,.green], startPoint: .top, endPoint: .bottom))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                })
                .alert("OHHH ERROR", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) { }
                        Button("Cancel", role: .cancel) { }
                }
            }}

        .ignoresSafeArea()
    }
}

#Preview {
    Pro2Part1()
}

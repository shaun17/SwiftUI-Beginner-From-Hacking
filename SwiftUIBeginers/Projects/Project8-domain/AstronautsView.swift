//
//  AstronautsView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/10.
//

import SwiftUI

struct AstronautsView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            .navigationTitle(astronaut.id)
            .background(.darkBackground)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautsView(astronaut: astronauts["white"]!).preferredColorScheme(.dark)
}

//
//  Pro8Part3.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/18.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

struct InsiderView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                Pro8Part4(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()

                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                }
            }
        }
    }
}

struct InsiderView2: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                Pro8Part4(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding()

                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                }
            }
        }
    }
}

struct Pro8Part3: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let colums = [
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]

    @State private var change = false

    var body: some View {
        NavigationStack {
            VStack {
                if change {
                    ScrollView { InsiderView2(missions: missions, astronauts: astronauts)
                    }
                    .navigationTitle("Moonshot")
                    .padding()
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)

                } else {
                    ScrollView {
                        LazyVGrid(columns: colums, content: {
                            InsiderView(missions: missions, astronauts: astronauts)
                        })
                        .padding([.horizontal, .bottom])
                    }
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar(content: {
                Button("Viwe", systemImage: "list.dash", action: {
                    change.toggle()

                })

            })
        }
    }
}

#Preview {
    Pro8Part3()
}

//
//  Pro8Part5-Challenge.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/19.
//

import SwiftUI

struct Pro8Part6_Challenge: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let colums = [
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]

    @State private var change = false
    @State private var path = NavigationPath()

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
                            ForEach(missions) { mission in
                                NavigationLink(value: mission) {
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
            .toolbar {
                Button("Viwe", systemImage: "list.dash", action: {
                    change.toggle()

                })

            }
            .navigationDestination(for: Mission.self) { mis in
                Pro8Part4(mission: mis, astronauts: astronauts)
            }
        
        }
           
    }
}

#Preview {
    Pro8Part6_Challenge()
}

//
//  Pro8Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/18.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct Pro8Part4: View {
    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.6)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.headline)
                        .opacity(0.7)
                        .padding(.bottom)
                }
              
                VStack(alignment: .leading, content: {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.description)
                    
                        .padding(.horizontal)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                        
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        
                })
            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crew in
                            NavigationLink {
                                Pro8Part5(astronaut: crew.astronaut)
                            } label: {
                                HStack {
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 70)
                                        .clipShape(.capsule)
                                        .overlay(Capsule().strokeBorder(.white, lineWidth: 1))
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(crew.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crew.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return Pro8Part4(mission: missions[3], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

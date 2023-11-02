//
//  SwiftUIViewMissionView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/9.
//

import SwiftUI

struct SwiftUIViewMissionView: View {
    let mission: Mission
    struct CrewMember {
        let rorle: String
        let astronaut: Astronaut
    }

    let crews: [CrewMember]

    var body: some View {
        NavigationView(content: {
            GeometryReader { geomtry in
                ScrollView {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geomtry.size.width * 0.5)
                            .padding(.top)
                        Text(mission.launchDate?.formatted(date: .complete, time: .standard) ?? "N/A")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                     
                        VStack {
                            Rectangle().frame(height: 2)
                                .foregroundColor(.lightBackground)
                                .padding(.vertical)
                            
                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                                
                            Text(mission.description)
                            
                            Rectangle().frame(height: 2)
                                .foregroundColor(.lightBackground)
                                .padding(.vertical)
                            
                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(crews, id: \.rorle) { crew in
                                    
                                    NavigationLink(
                                        destination: AstronautsView(astronaut: crew.astronaut),
                                        label: {
                                            HStack {
                                                Image(crew.astronaut.id)
                                                    .resizable()
                                                    .frame(width: 104, height: 72)
                                                    .clipShape(Capsule())
                                                    .overlay {
                                                        Capsule().strokeBorder(.white, lineWidth: 1)
                                                    }
                                                VStack {
                                                    Text(crew.astronaut.name)
                                                        .foregroundColor(.white)
                                                        .font(.headline)
                                                    Text(crew.rorle)
                                                        .foregroundColor(.secondary)
                                                }
                                                
                                                Rectangle().frame(width: 2)
                                                    .foregroundColor(.lightBackground)
                                                    .padding(.horizontal)
                                            }
                                            .padding(.horizontal)
                                        })
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            
        })
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crews = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(rorle: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

//
// #Preview {
//    let mission: [Mission] = Bundle.main.decode("mission.json")
//    return SwiftUIViewMissionView(mission: mission[0])
// }

struct SwiftUIViewMissionView_Previews: PreviewProvider {
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        SwiftUIViewMissionView(mission: mission[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

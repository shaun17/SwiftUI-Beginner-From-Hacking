//
//  Project8.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/9.
//

import SwiftUI

struct Project8: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let colums = [GridItem(.adaptive(minimum: 150))]
    var body: some View {
        NavigationView(content: {
            ScrollView {
                
                LazyVGrid(columns: colums, content: {
                    ForEach(missions) { mission in
                        NavigationLink(destination: Text("Destination")) {
                            
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .padding(20)
                                    
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(String(mission.displayLaunchDate))
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))

                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                          
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                        }
                        
                    }
                      
                })
                .padding([.horizontal, .bottom, .top])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
        })
    }
}

#Preview {
    Project8()
}

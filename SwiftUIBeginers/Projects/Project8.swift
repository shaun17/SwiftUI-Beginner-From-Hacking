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
    
    @State private var changeShow = true
    var body: some View {
        NavigationView(content: {
            
            ScrollView {

                if changeShow {
                  
                        
                        ForEach(missions) { mission in
                           
                                
                                NavigationLink(destination: SwiftUIViewMissionView(mission:mission, astronauts: astronauts)) {
                                    HStack{
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50)
                                            .padding(10)
                                        
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
                                .border(.lightBackground, width: 5)
                                .padding([.horizontal,.top])
                             
                        
                        }
                        
                    
                    
                    
                    
                } else{
                    
                    LazyVGrid(columns: colums, content: {
                        ForEach(missions) { mission in
                            NavigationLink(destination: SwiftUIViewMissionView(mission: mission, astronauts: astronauts)) {
                                
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
                
                
     
                
                
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Change"){
                    withAnimation(.easeIn){
                        changeShow.toggle()
                    }
                    
                }
                
            }
            
        })
    }
}

#Preview {
    Project8()
}

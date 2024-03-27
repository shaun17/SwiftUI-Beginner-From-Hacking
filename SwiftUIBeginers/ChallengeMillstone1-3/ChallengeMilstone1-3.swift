//
//  ChallengeMilestone.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/13.
//

import SwiftUI

extension View{
    func diycolorful(_ flag: Bool) -> some View {
        if flag {
            return background(LinearGradient(colors: [.yellow,.green,.cyan,.white], startPoint: .top, endPoint: .bottom))
        } else {
            return  background(LinearGradient(colors: [.orange,.pink,.purple,.blue], startPoint: .top, endPoint: .bottom))
        }
    }
}

struct ChallengeMilestone: View {
    var items = ["✊", "👋", "✌️"]
    @State var botItem = ""
    @State var tips = ""
    @State var round = 0
    @State var winScore = 0
    @State var failScore = 0
    @State var draw = 0
    @State var showNewRound = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple], startPoint: .top, endPoint: .bottom)
            
            
            VStack{
                Spacer()
                
                Text("Round  \(round)")
                    .font(.title.bold())
                    .foregroundStyle(.pink)
                Spacer()
                Text(tips)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.blue)
                    
                Spacer()
                
                Text("BOT Chosen")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                Button {
                    
                } label: {
                    Text(botItem == "" ? "❓" : botItem)
                        .padding(12)
                        .diycolorful(botItem == "")
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .disabled(true)
                

                
                Text("You Chose One")
                    .font(.title.bold())
                    .foregroundStyle(.purple)
             
                
                HStack{
                    ForEach(items, id: \.self){ item in
                        Button(action: {compare(item)}   , label: {
                            Text(item)
                                .padding(12)
                                .diycolorful(false)
                                .clipShape(RoundedRectangle(cornerRadius: 15))

                        })
                        .alert("Round Over", isPresented: $showNewRound) {
                            Button("START") {
                            
                                reStart()
                            }
                        } message: {
                            Text("Win Score is \(winScore) \n Lose Score is \(failScore) \n Enqual Score is \(draw)")
                        }.font(.title)
                        
                    }
                }
                Spacer()
                Spacer()
                
            }
           
        }
        .ignoresSafeArea()
        
    }
    
    func compare(_ user: String){
        round += 1
        botItem = items.randomElement()!
        var win = false
        
        if botItem == user {
            draw += 1
            addROund()
            tips = "🤠 Try Again"
            return
        }
        
        switch botItem {
        case "✊":
            if user == "👋" {
                win = true
                
            }
            break
        case "👋":
            if user == "✌️" {
                win = true
            }
            break
        case "✌️":
            if user == "✊" {
                win = true
            }
            break
        default:
            break
        }
        
        if win {
            winScore += 1
            tips = "😘YOU WIN!!"
        } else {
            failScore += 1
            tips = "🫣OH NOOO!!"
        }
        addROund()
        
    }
    
    func addROund(){
        if round == 5 {
            showNewRound = true
        }
    }
    func reStart(){
        botItem = ""
         tips = ""
         round = 0
         winScore = 0
         failScore = 0
         draw = 0
         showNewRound = false
    }
}

#Preview {
    ChallengeMilestone()
}

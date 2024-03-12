//
//  ProPart2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/12.
//VStack, LinearGradient, alerts, and more.


import SwiftUI

struct ProPart2: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]
        .shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var newRound = false

    @State private var scoreTitle = ""
    @State private var scorce = 0
    @State private var round = 0
    @State private var chose = 0

    var body: some View {
        ZStack{
            
            RadialGradient(gradient: .init(colors: [Color(red: 0.2, green: 0.2, blue: 0.45),
                                                    Color(red: 0.7, green: 0.15, blue: 0.26)]), center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15, content: {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(color: .purple, radius: 5)
                                
                        }
                    }
                })
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scorce)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Got it", action: askQuestion)
            }message: {
                Text("Oh, It's Wrong, this is \(countries[chose])")
                
            }
            .alert("new Round", isPresented: $newRound) {
                Button("continue", action: reStar)
            }message: {
                Text("round end, your score is \(scorce)")

            }
            .padding()

          
        }
       
    }
    
    
    func flagTapped(_ number: Int){
        chose = number
        round += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            scorce += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong"
            scorce -= 1
            showingScore = true
        }
        if round == 8 {
            newRound = true
            return
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func reStar(){
        round = 0
        scorce = 0
        newRound = false
        askQuestion()
    }
}

#Preview {
    ProPart2()
}

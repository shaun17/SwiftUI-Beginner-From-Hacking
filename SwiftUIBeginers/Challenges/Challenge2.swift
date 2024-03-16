//
//  Challenge2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/12.
//

import SwiftUI

struct Challenge2: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]
        .shuffled()
    
    @State private var rotationDegrees: [Int: Double] = [0: 0, 1: 0, 2: 0]

    @State var correctAnswer = Int.random(in: 0...2)
        
    @State private var showingScore = false
    @State private var newRound = false

    @State private var scoreTitle = ""
    @State private var scorce = 0
    @State private var round = 0
    @State private var chose = 0
    @State private var animationAmount = 0.0
    @State private var selectedNumber: Int? = nil
    @State private var isButtonClicked: Bool = false


    
    var body: some View {
        ZStack {
            RadialGradient(gradient: .init(colors: [Color(red: 0.2, green: 0.2, blue: 0.45),
                                                    Color(red: 0.7, green: 0.15, blue: 0.26)]), center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
                
            VStack {
                Spacer()
                Text("Guess the Flag")
//                        .font(.largeTitle.bold())
//                        .foregroundColor(.white)
                    .diyLargeTitle()
                    
                VStack(spacing: 15, content: {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                        
                    ForEach(0 ..< 3) { number in
                        Button {
                            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                                rotationDegrees[number]! += 360
                                print(rotationDegrees)
                                selectedNumber = number
                                isButtonClicked = true
                            }
                            
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                                    
                                    flagTapped(number)
                                }
                
                                                }

                        } label: {
                            FlagImage(countries: countries, number: number)
                                .rotation3DEffect(
                                    .degrees(rotationDegrees[number] ?? 0),
                                    axis: (x: 1.0, y: 0.0, z: 0.0)
                                )
                                .opacity((selectedNumber == number  || !isButtonClicked ) ? 1 : 0.25)
                                .scaleEffect(selectedNumber == number || selectedNumber == nil ? 1 : 0.9)

                                
                            }


                    }
                })
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
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
            } message: {
                Text("Oh, It's Wrong, this is \(countries[chose])")
            }
            .alert("new Round", isPresented: $newRound) {
                Button("continue", action: reStar)
            } message: {
                Text("round end, your score is \(scorce)")
            }
            .padding()
        }
    }
        
    func flagTapped(_ number: Int) {
        chose = number
        round += 1
        isButtonClicked = false
        selectedNumber = nil
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
        
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
        
    func reStar() {
        round = 0
        scorce = 0
        newRound = false
        askQuestion()
    }
}

struct FlagImage: View {
    var countries: [String]
    var number: Int
    var body: some View {
        Image(countries[number])
            .clipShape(.capsule)
            .shadow(color: .purple, radius: 5)
    }
}

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

extension View {
    func diyLargeTitle() -> some View {
        modifier(LargeTitle())
    }
}

#Preview {
    Challenge2()
}

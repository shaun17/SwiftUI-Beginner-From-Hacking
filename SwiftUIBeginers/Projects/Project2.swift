//
//  Project2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/27.
//

import SwiftUI

struct Project2: View {
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: .blue, location: 0.3),
                .init(color: .yellow, location: 0.7)], center: .top, startRadius: 200, endRadius: 700)
            
            VStack(spacing: 15) {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack {
                    VStack {
                        Text("Tag the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0 ..< 3) { number in
                        Button {
                            gussFlag(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 20)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Text("Score: ???")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is ???")
                .foregroundColor(.white)
                .font(.title.bold())
        }
        .ignoresSafeArea()
        
    }

    func gussFlag(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct🎉"
        } else {
            scoreTitle = "Wrong❌"
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct Project2_Previews: PreviewProvider {
    static var previews: some View {
        Project2()
    }
}

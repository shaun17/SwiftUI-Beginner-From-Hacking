//
//  Pro17Part5.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import Combine
import SwiftUI

struct Card: Identifiable {
    var id: UUID
    var prompt: String
    var answer: String

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

extension View {
    func stack(at position: Int, in total: Int) -> some View {
        let offSet = Double(total - position)
        return offset(y: offSet * 10)
    }
}

struct Pro17Part5View: View {
    @State private var cards = [Card](repeating: .example, count: 10)
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(0 ..< cards.count, id: \.self) { index in
                        Pro17Part5(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stack(at: index, in: cards.count)
                    }
                }
            }

            if accessibilityDifferentiateWithoutColor {
                VStack {
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                    Spacer()
                    Image(systemName: "checkmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
            }
        }
        .onReceive(timer, perform: { _ in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        })
        .onChange(of: scenePhase) {
            if scenePhase == .active {
               isActive = true
            } else {
               isActive = false
            }
        }
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct Pro17Part5: View {
    let card: Card
    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offSet = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(
                    accessibilityDifferentiateWithoutColor ?
                        .white : .white.opacity(1 - Double(offSet.width / 50)))
                .background(content: {
                    accessibilityDifferentiateWithoutColor ?
                        nil :
                        RoundedRectangle(cornerRadius: 35)
                        .fill(offSet.width > 0 ? .green : .red)
                })
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offSet.width / 2))
        .offset(x: offSet.width * 5, y: offSet.height * 1.5)
        .opacity(1 - Double(abs(offSet.width / 50)))
        .gesture(DragGesture()
            .onChanged { gesture in
                print(gesture.translation.width)
                offSet = gesture.translation
            }
            .onEnded { _ in
                if abs(offSet.width) > 0 {
                    removal?()

                } else {
                    offSet = .zero
                }
            })
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    Pro17Part5View()
}

//
//  Pro17Part5.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/2.
//

import Combine
import SwiftUI

struct Card: Identifiable, Codable {
    var id: UUID
    var prompt: String
    var answer: String

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

extension View {
    func stack(at position: Int, in total: Int) -> some View {
        let offSet = Double(total - position)
        return offset(x: CGSize.zero.width, y: offSet * 10)
    }
}

struct Pro17Part5View: View {
    @State private var cards = [Card]()
    @State private var cards_bak = [Card]()

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true

    @State private var showingEditScreen = false
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

    @State private var review = false

    var body: some View {
        ZStack {
            Image(decorative: "background")
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
                        Pro17Part5(card: cards[index]) { isLeftSwipe in
                            withAnimation {
                                guard index >= 0 else { return }
                                removeCard(at: index, isLeftSwipe: isLeftSwipe)
                            }
                        }
                        .stack(at: index, in: cards.count)
//                        .opacity(1)
//                        .rotationEffect(.zero)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)

                if cards.isEmpty {
                    Button("Restar") {
                        resetCards()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                }
            }

            VStack {
                HStack {
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()

            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isLeftSwipe: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, isLeftSwipe: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    Spacer()
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
            if scenePhase == .active && !cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            Pro17Part6()
        }
        .onAppear {
            resetCards()
        }
    }

    func removeCard(at index: Int, isLeftSwipe: Bool, review _: Bool = false) {
        print(index)

        let card = cards.remove(at: index)

        if isLeftSwipe {
            // 如果是向左滑动，将卡片添加到cards_bak数组中
            cards_bak.append(card)
        }
        if cards.isEmpty && !cards_bak.isEmpty {
            cards = cards_bak.reversed()
            cards_bak.removeAll()
        }

        if cards.isEmpty {
            isActive = false
        }
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
}

struct Pro17Part5: View {
    init(card: Card, removal: ((Bool) -> Void)? = nil) {
        // 创建一个全新的Card实例，其内部值与传入的cardold实例相同
        self.card = Card(id: UUID(), prompt: card.prompt, answer: card.answer)
        self.removal = removal
    }

    let card: Card

    var removal: ((Bool) -> Void)? = nil

    @State private var isShowingAnswer = false
    @State private var offSet = CGSize.zero
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

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
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offSet.width / 5))
        .offset(x: offSet.width * 5)
        .opacity(1 - Double(abs(offSet.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offSet = gesture.translation
                }
                .onEnded { _ in
                    if abs(offSet.width) > 0 {
                        removal?(offSet.width < 0)
                    }
                    DispatchQueue.main.async {
                        offSet = .zero
                    }

                })
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    Pro17Part5View()
}

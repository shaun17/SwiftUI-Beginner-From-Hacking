//
//  Pro17Part7.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/21.
//

import SwiftUI

struct Pro17Part7: View {
    // 一个时间工具，每一秒动态链接
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 100
    @State private var cards = [Card]()
    @State private var review = false
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false

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
                    if !review {
                        ForEach(Array(cards.enumerated()), id: \.1.id) { index, card in
                            Pro17CardSubView(card: card) { isLeftSwipe in
                                withAnimation {
                                    guard index >= 0 else { return }
                                    removeCardByIndex(at: index, card: card, isLeftSwipe: isLeftSwipe)
                                }
                            }
                            .stack(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        }
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
        .alert(isPresented: $review, content: {
            Alert(title: Text("Review"), dismissButton: Alert.Button.default(Text("OK"), action: {
                review = false
            }))
        })
    }

    func removeCardByIndex(at index: Int, card: Card, isLeftSwipe: Bool) {
        // 获取索引值
        if let i = cards.firstIndex(where: {$0.id == card.id}){
            let car = cards.remove(at: i)
        }
        
        // 如果是向左滑动，将卡片添加到cards_bak数组中
        if isLeftSwipe {
            cards.insert(card, at: 0)
        }
        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

struct Pro17CardSubView: View {
    let card: Card
    let index = 0
    var removal: (Bool) -> Void

    init(card: Card, removal: @escaping (Bool) -> Void) {
        self.card = card
        self.removal = removal
    }

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
                        removal(offSet.width < 0)
                        if index == 0 {
                            offSet = .zero
                        }
                    } else {
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
    Pro17Part7()
}

//
//  DropViewDelegate.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/20.
//

import SwiftUI
import UniformTypeIdentifiers


struct Fruit: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var gradientColors: [Color]
}

class FruitsListViewModel: ObservableObject {
@Published var draggedItem: Fruit?
    @Published var fruits: [Fruit] = [
      Fruit(
          title: "Blueberry",
          description: "Blueberries are sweet, nutritious and wildly popular fruit all over the world.",
          image: "blueberry",
          gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
        ),
        Fruit(
          title: "Strawberry",
          description: "Widely appreciated for its characteristic aroma,  red color, juicy texture, and sweetness.",
          image: "strawberry",
          gradientColors: [Color("ColorStrawberryLight"), Color("ColorStrawberryDark")]
        ),
        Fruit(
          title: "Lemon",
          description: "There's no doubt lemons are delicious, but does adding them to water make you healthier?",
          image: "lemon",
          gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]
        ),
        Fruit(
          title: "Plum",
          description: "Plums are a very nutritious fruit. An excellent source of vitamins, minerals, fiber and antioxidants.",
          image: "plum",
          gradientColors: [Color("ColorPlumLight"), Color("ColorPlumDark")]
        
        ),
        Fruit(
          title: "Lime",
          description: "Sour, round, and bright green citrus fruits. Limes are high in vitamin C, antioxidants, and other nutrients.",
          image: "lime",
          gradientColors: [Color("ColorLimeLight"), Color("ColorLimeDark")]
       
        ),
        Fruit(
          title: "Pear",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "pear",
          gradientColors: [Color("ColorPearLight"), Color("ColorPearDark")]
        
        ),
        Fruit(
          title: "Gooseberry",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "gooseberry",
          gradientColors: [Color("ColorGooseberryLight"), Color("ColorGooseberryDark")]
         
        ),
        Fruit(
          title: "Mango",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "mango",
          gradientColors: [Color("ColorMangoLight"), Color("ColorMangoDark")]
         
        ),
        Fruit(
          title: "Watermelon",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "watermelon",
          gradientColors: [Color("ColorWatermelonLight"), Color("ColorWatermelonDark")]
         
        ),
        Fruit(
          title: "Cherry",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "cherry",
          gradientColors: [Color("ColorCherryLight"), Color("ColorCherryDark")]
         
        ),
        Fruit(
          title: "Grapefruit",
          description: "Sweet, bell-shaped fruits that have been enjoyed since ancient times. They can be eaten crisp or soft.",
          image: "grapefruit",
          gradientColors: [Color("ColorGrapefruitLight"), Color("ColorGrapefruitDark")]
        
        ),
        Fruit(
          title: "Apple",
          description: "Apples are one of the most popular, and exceptionally healthy fruit for good reason.",
          image: "apple",
          gradientColors: [Color("ColorAppleLight"), Color("ColorAppleDark")]
        
        )
    ]

}

struct FruitCellView: View {
    let fruit: Fruit
    
    var body: some View {
        HStack {
            Image(fruit.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .shadow(radius: 5)
                .padding(.leading, 10)
            Spacer()
            VStack(alignment: .leading) {
                Text(fruit.title)
                    .font(.title)
                    .bold()
                    .shadow(radius: 5)
                    .padding(.bottom, 5)
                Text(fruit.description)
                    .shadow(radius: 5)
            }
            Spacer()
            Image(systemName: "line.3.horizontal")
                .frame(width: 30)
                .shadow(radius: 5)
                .padding(.trailing, 10)
        }
        .foregroundColor(.white)
        .frame(minWidth: 150, idealWidth: 360, maxWidth: 500)
        .frame(height: 150)
        .background(
            LinearGradient(
                gradient: Gradient(colors: fruit.gradientColors),
                startPoint: .top,
                endPoint: .bottom))
        .cornerRadius(15)
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
     
        
    }
}

struct FruitsListScreen: View {
    @StateObject var viewModel = FruitsListViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.fruits) { fruit in
                        FruitCellView(fruit: fruit)
                            .onDrag({
                                viewModel.draggedItem = fruit
                                print(11)
                                return NSItemProvider(item: nil, typeIdentifier: fruit.title)
                            })
                            .onDrop(of: [UTType.text], delegate:   DragAndDropService<Fruit>(currentItem: fruit, items: $viewModel.fruits, draggedItem: $viewModel.draggedItem)
                            )
                    }
                }.padding(.vertical, 20)
            }.navigationTitle("List drag and drop 🔥")
        }
    }
}

struct DragAndDropService<T: Equatable>: DropDelegate {
    let currentItem: T
    @Binding var items: [T]
    @Binding var draggedItem: T?

    func performDrop(info _: DropInfo) -> Bool {
        return true
    }

    func dropEntered(info _: DropInfo) {
        print(2)
        guard let draggedItem = draggedItem,
              draggedItem != currentItem,
              let from = items.firstIndex(of: draggedItem),
              let to = items.firstIndex(of: currentItem)
        else {
            return
        }
        withAnimation {
            items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
        }
    }
}

#Preview {
    FruitsListScreen()
}

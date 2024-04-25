//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/24.
//

import SwiftUI

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found - \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(_, context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

extension Pro19Part5 {
    struct Resort: Codable, Identifiable, Hashable {
        var id: String
        var name: String
        var country: String
        var description: String
        var imageCredit: String
        var price: Int
        var size: Int
        var snowDepth: Int
        var elevation: Int
        var runs: Int
        var facilities: [String]

        static var allResorts: [Resort] {
            Bundle.main.decode("resorts.json")
        }

        static let example = allResorts[0]

        var facilityTypes: [Pro19Part5.Facility] {
            facilities.map(Pro19Part5.Facility.init)
        }

//        static func < (lhs: Resort, rhs: Resort) -> Bool {
//            lhs.name < rhs.name
//        }
    }

    struct Facility: Identifiable {
        let id = UUID()
        var name: String

        private let icons = [
            "Accommodation": "house",
            "Beginners": "1.circle",
            "Cross-country": "map",
            "Eco-friendly": "leaf.arrow.circlepath",
            "Family": "person.3",
        ]

        var icon: some View {
            if let iconName = icons[name] {
                return Image(systemName: iconName)
                    .accessibilityLabel(name)
                    .foregroundStyle(.secondary)
            } else {
                fatalError("Unknown facility type: \(name)")
            }
        }

        private let descriptions = [
            "Accommodation": "This resort has popular on-site accommodation.",
            "Beginners": "This resort has lots of ski schools.",
            "Cross-country": "This resort has many cross-country ski routes.",
            "Eco-friendly": "This resort has won an award for environmental friendliness.",
            "Family": "This resort is popular with families.",
        ]

        var description: String {
            if let message = descriptions[name] {
                return message
            } else {
                fatalError("Unknown facility type: \(name)")
            }
        }
    }

    struct WelcomeView: View {
        var body: some View {
            VStack {
                Text("Welcome to SnowSeeker!")
                    .font(.largeTitle)

                Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                    .foregroundStyle(.secondary)
            }
        }
    }

    struct SkiDetailsView: View {
        let resort: Resort
        var body: some View {
            Group {
                VStack {
                    Text("Elevation")
                        .font(.caption.bold())
                    Text("\(resort.elevation)m")
                        .font(.title)
                }
                VStack {
                    Text("Snow")
                        .font(.caption.bold())
                    Text("\(resort.snowDepth)cm")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }

    struct ResortDetailsView: View {
        let resort: Resort
        var size: String {
            switch resort.size {
            case 1: "Small"
            case 2: "Average"
            default: "Large"
            }
        }

        var price: String {
            String(repeating: "$", count: resort.price)
        }

        var body: some View {
            Group {
                VStack {
                    Text("Size")
                        .font(.caption.bold())
                    Text(size)
                        .font(.title)
                }
                VStack {
                    Text("Price")
                        .font(.caption.bold())
                    Text(price)
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
        }
    }

    struct ResortView: View {
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.dynamicTypeSize) var dynamicTypeSize
        @Environment(Favorites.self) var favorites

        @State private var selectedFacility: Facility?
        @State private var showingFacility = false

        let resort: Resort
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0, content: {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()

                    HStack {
                        if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                            VStack(spacing: 10) { Pro19Part5.ResortDetailsView(resort: resort) }
                            VStack(spacing: 10) { Pro19Part5.SkiDetailsView(resort: resort) }

                        } else {
                            Pro19Part5.ResortDetailsView(resort: resort)
                            Pro19Part5.SkiDetailsView(resort: resort)
                        }
                    }
                    .padding(.vertical)
                    .background(.primary.opacity(0.1))

                    Group {
                        Text(resort.description)
                            .padding(.vertical)
                        Text("Facilities")
                            .font(.headline)

                        HStack {
                            ForEach(resort.facilityTypes) { facility in
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    facility.icon
                                        .font(.title)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                })

                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
        }
    }

    @Observable
    class Favorites {
        private var resorts: Set<String>
        private static var key = "Facorites"
        init() {
            if let data = UserDefaults.standard.array(forKey: Pro19Part5.Favorites.key) as? [String] {
                resorts = Set(data)
                return
            }
            resorts = []
        }

        func contains(_ resort: Pro19Part5.Resort) -> Bool {
            resorts.contains(resort.id)
        }

        func add(_ resort: Pro19Part5.Resort) {
            resorts.insert(resort.id)
            save()
        }

        func remove(_ resort: Pro19Part5.Resort) {
            resorts.remove(resort.id)
            save()
        }

        func save() {
            UserDefaults.standard.set(Array(resorts), forKey: Pro19Part5.Favorites.key)
        }
    }
}

struct Pro19Part5: View {
    let restorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var favorites = Favorites()

    @State private var searchText = ""

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            restorts.sorted { $0.name < $1.name }
        } else {
            restorts.filter { $0.name.localizedStandardContains(searchText) }.sorted { $0.name < $1.name }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        VStack(alignment: .leading, content: {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        })
                    }
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Restores")
            .navigationDestination(for: Resort.self) { restort in
                ResortView(resort: restort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        .navigationSplitViewStyle(.balanced)
        .environment(favorites)
    }
}

#Preview {
    Pro19Part5()
}

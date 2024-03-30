//
//  Pro14Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/29.
//
//

import MapKit
import SwiftUI

struct LocationPro14: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static let example = LocationPro14(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", latitude: 51.501, longitude: -0.141)

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

struct Pro14Part4: View {
//    @State private var locations = [LocationPro14]()
//    @State private var seletedPlace: LocationPro14?
//
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))

    @State private var viewModel = ViewModel()

    var body: some View {
        if viewModel.isUnlocked {
            
            MapReader { proxy in
                
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        
                        //                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 20, height: 20)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(.hybrid)
                .onTapGesture { position in
                    print("Tapped at \(position)")
                    if let coordinate = proxy.convert(position, from: .local) {
                        //                    let newLocation = LocationPro14(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        viewModel.addLocation(at: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditViewPro14(location: place) { newLocation in
                    
                    viewModel.update(location: newLocation)
                    //                if let index = viewModel.locations.firstIndex(of: place) {
                    //                    viewModel.locations[index] = newLocation
                    //                }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }

}

struct EditViewPro14: View {
    @State private var name: String
    @State private var description: String

    enum LoadingState {
        case loading, loaded, failed
    }

    @State private var loadingState = LoadingState.loading
    @State private var pages = [PagePro14]()

    var onSave: (LocationPro14) -> Void

    var location: LocationPro14

    @Environment(\.dismiss) var dismiss

    init(location: LocationPro14, onSave: @escaping (LocationPro14) -> Void) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }

                Section("NearBy...") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }

                    case .loading:
                        Text("Loading")

                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button("Save") {
                    let newLocation = LocationPro14(id: UUID(), name: name, description: description, latitude: location.latitude, longitude: location.longitude)

                    onSave(newLocation)
                    dismiss()
                }
            })
            .task {
                await fetchNearbyPlaces()
            }
        }
    }

    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(ResultPro14.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded

        } catch {
            loadingState = .failed
        }
    }
}

#Preview {
    Pro14Part4()
//    EditViewPro14(location: .example){ _ in}
}

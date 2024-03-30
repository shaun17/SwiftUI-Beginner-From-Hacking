//
//  Pro14Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/29.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct Pro14Part2: View {
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
    ]

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )

    var body: some View {
        HStack {
            Button("Paris") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
            Button("Tokyo") {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
            }
        }

        MapReader { proxy in
            Map()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        print(coordinate)
                    }
                }
        }
        // 地图打点
//        Map{
//            ForEach(locations){ location in
//                Marker(location.name, coordinate: location.coordinate)
//
//                    // 自定义标记打点
        ////                Annotation(location.name, coordinate: location.coordinate) {
        ////                    Text(location.name)
        ////                        .font(.headline)
        ////                        .padding()
        ////                        .background(.blue)
        ////                        .foregroundStyle(.white)
        ////                        .clipShape(.capsule)
        ////                }
        ////                .annotationTitles(.hidden)
//            }
//        }

        Map(position: $position)
            //            .mapStyle(.imagery)
            .mapStyle(.hybrid(elevation: .realistic))
            .onMapCameraChange(frequency: .continuous) { context in
                print(context.region)
            }
    }
}

#Preview {
    Pro14Part2()
}

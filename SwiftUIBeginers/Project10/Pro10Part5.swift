//
//  Pro10Part5.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/21.
//

import SwiftUI

@Observable
class AddressPro: Codable {
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    init(name: String = "", streetAddress: String = "", city: String = "", zip: String = "") {
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
    }
}

@Observable
class OrderPro10: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quality = "quality"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraForsing = "extraForsing"
        case _addSprinkle = "addSprinkle"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quality = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraForsing = false
                addSprinkle = false
            }
        }
    }

    var extraForsing = false
    var addSprinkle = false

    var addressPro = AddressPro()

    var hasValidAddress: Bool {
        if addressPro.name.isEmpty || addressPro.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || addressPro.city.isEmpty || addressPro.zip.isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        var cost = Double(quality) * 2
        cost += (Double(type) / 2)
        if extraForsing {
            cost += Double(quality)
        }
        if addSprinkle {
            cost += Double(quality) / 2
        }
        return cost
    }
}

struct Pro10Part5: View {
    @State private var order = OrderPro10()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(OrderPro10.types.indices, id: \.self) {
                            Text(OrderPro10.types[$0])
                        }
                    }
                    Stepper("Number of cake \(order.quality)", value: $order.quality, in: 3 ... 30)
                }

                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraForsing)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkle)
                    }
                }

                Section {
                    NavigationLink(destination: AddressViewPro10(order: order)) {
                        Text("add a delivery")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct AddressViewPro10: View {
    @Bindable var order: OrderPro10
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.addressPro.name)
                TextField("Street Address", text: $order.addressPro.streetAddress)
                TextField("City", text: $order.addressPro.city)
                TextField("Zip", text: $order.addressPro.zip)
            }

            Section {
                NavigationLink("Check out ") {
                    CheckoutViewPro10(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            Button("save address") {
                saveAddress(order)
            }
        })
    }

    func saveAddress(_ order: OrderPro10) {
        let addredd = AddressPro(name: order.addressPro.name, streetAddress: order.addressPro.streetAddress, city: order.addressPro.city, zip: order.addressPro.zip)
        if let encoder = try? JSONEncoder().encode(addredd) {
            UserDefaults.standard.setValue(encoder, forKey: "addressInfo")
        }
    }

    init(order: OrderPro10) {
        self.order = order
        if let address = UserDefaults.standard.data(forKey: "addressInfo") {
            if let data = try? JSONDecoder().decode(AddressPro.self, from: address) {
                order.addressPro = data
            }
        }
    }
}

#Preview {
    Pro10Part5()
}

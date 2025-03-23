import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var car: Car = Car(model: "")
    @Published var showTrafficLight = false
    @Published var showAlert = false

    func validateInput() {
        showTrafficLight = car.isValid
        showAlert = !car.isValid
    }
}

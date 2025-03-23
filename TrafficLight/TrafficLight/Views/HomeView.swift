import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter your car model:")
                    .font(.headline)
                
                TextField("Car Model", text: $viewModel.car.model)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.words)
                
                Button("Start Driving") {
                    viewModel.validateInput()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Invalid Car Model"),
                        message: Text("Car model must be at least 3 characters long."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.showTrafficLight) {
                TrafficLightView(carModel: viewModel.car, viewModel: TrafficLightViewModel())
            }
        }
    }
}

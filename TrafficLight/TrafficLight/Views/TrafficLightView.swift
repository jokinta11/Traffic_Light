import SwiftUI

struct TrafficLightView: View {
    let carModel: Car
    @StateObject var viewModel: TrafficLightViewModel
    
    var body: some View {
        VStack {
            Text("Car Model: \(carModel.model)")
                .font(.title)
                .padding()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black)
                    .frame(width: 120, height: 300)
                
                VStack(spacing: 16) {
                    TrafficLightCircleView(traficLight: TrafficLightState.red, isActive: viewModel.currentLight == .red)
                    TrafficLightCircleView(traficLight: TrafficLightState.orange, isActive: viewModel.currentLight == .orange)
                    TrafficLightCircleView(traficLight: TrafficLightState.green, isActive: viewModel.currentLight == .green)
                }
                .padding(16)
            }
            .padding(.top, 20)
        }
        .onAppear {
            viewModel.startTrafficLightCycle(from: .green)
        }
        .onDisappear() {
            viewModel.stopTrafficLightCycle()
        }
    }
}

import SwiftUI

class TrafficLightViewModel: ObservableObject {
    @Published var currentLight: TrafficLightState = .green
    
    private var previousLight: TrafficLightState = .green
    private var isRunning: Bool = false
    
    func startTrafficLightCycle(from initialState: TrafficLightState = .green) {
        guard !isRunning else { return }
        isRunning = true
        currentLight = initialState
        cycleNextLight(from: currentLight)
    }
    
    func stopTrafficLightCycle() {
        isRunning = false
    }
    
    private func cycleNextLight(from current: TrafficLightState) {
        guard isRunning else { return }
        self.currentLight = current
        
        print("DEBUG: \(Date().seconds) - Changing light from \(previousLight) to \(current)")
        
        switch current {
        case .red, .green:
            previousLight = current
            delay(seconds: 4) {
                self.updateTrafficLight(nextLight: .orange)
            }
        case .orange:
            delay(seconds: 1) {
                self.updateTrafficLight(nextLight: self.nextLightAfterOrange())
            }
        }
    }
    
    func nextLightAfterOrange() -> TrafficLightState {
        previousLight == .red ? .green : .red
    }
    
    private func updateTrafficLight(nextLight: TrafficLightState) {
        self.cycleNextLight(from: nextLight)
        
    }
    
    private func delay(seconds: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds), execute: completion)
    }
}

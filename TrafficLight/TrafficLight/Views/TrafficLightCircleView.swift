import SwiftUI

struct TrafficLightCircleView: View {
    let traficLight: TrafficLightState
    let isActive: Bool

    var body: some View {
        Circle()
            .fill(traficLight.color.opacity(isActive ? 1.0 : 0.3))
            .frame(width: 60, height: 60)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: isActive ? 3 : 0)
            )
            .animation(.easeInOut(duration: 0.3), value: isActive)
    }
}

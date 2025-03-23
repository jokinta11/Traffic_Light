import Foundation
import SwiftUI

enum TrafficLightState {
    case red, green, orange

    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .orange:
            return .orange
        }
    }
}

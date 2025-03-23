import Foundation

// MARK: - Date Extensions

extension Date {
    var seconds: Int {
        return Calendar.current.component(.second, from: self)
    }
}

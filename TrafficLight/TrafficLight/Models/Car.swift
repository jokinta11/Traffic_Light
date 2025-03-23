import Foundation

struct Car {
    var model: String

    var isValid: Bool {
        return model.trim().count >= 3
    }
}

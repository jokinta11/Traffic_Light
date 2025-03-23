import Foundation

// MARK: - String Extensions

extension String {
    func trim() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
   }
}

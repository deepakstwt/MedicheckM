import SwiftUI

struct Medicine: Identifiable {
    var id = UUID()
    var name: String
    var expiryStatus: String
    var statusColor: Color
    var uses: String
    var dosage: String
    var warnings: String
}

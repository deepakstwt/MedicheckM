import SwiftUI

struct MedicineCardView: View {
    var medicine: Medicine
    
    var body: some View {
        NavigationLink(destination: MedicineDetailView(medicine: medicine)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(medicine.name)
                        .font(.headline)
                    Text(medicine.expiryStatus)
                        .foregroundColor(medicine.statusColor)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 3)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

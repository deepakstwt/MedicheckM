import SwiftUI

struct MedicineStatusView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Medicine Status")
                .font(.headline)
            
            MedicineCardView(medicine: Medicine(
                name: "Amoxicillin 500mg",
                expiryStatus: "Expiring in 2 days",
                statusColor: .red,
                uses: "Treats bacterial infections",
                dosage: "1 Tablet, Twice a Day",
                warnings: "Avoid alcohol, take with food"
            ))
            
            MedicineCardView(medicine: Medicine(
                name: "Ibuprofen 400mg",
                expiryStatus: "Expiring in 7 days",
                statusColor: .orange,
                uses: "Pain reliever",
                dosage: "1 Tablet every 6 hours",
                warnings: "May cause stomach irritation"
            ))
            
            MedicineCardView(medicine: Medicine(
                name: "Paracetamol 650mg",
                expiryStatus: "Safe - Expires in 3 months",
                statusColor: .green,
                uses: "Fever and pain relief",
                dosage: "1 Tablet every 4-6 hours",
                warnings: "Avoid overdose"
            ))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
    }
}

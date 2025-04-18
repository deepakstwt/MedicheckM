import SwiftUI
import RealityKit

struct MedicineDetailView: View {
    var medicine: Medicine

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
      
                RealityKitPillView()
                    .frame(height: 380)
                    .padding(.horizontal)
                
                
                VStack(spacing: 5) {
                    Text(medicine.name)
                        .font(.title2).bold()
                        .foregroundColor(.blue)
                    
                    Text(medicine.expiryStatus)
                        .foregroundColor(medicine.statusColor)
                        .font(.headline)
                        .padding(.top, 2)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 10))
                .padding(.horizontal)

             
                VStack(alignment: .leading, spacing: 12) {
                    DetailRow(icon: "book.fill", title: "Uses", value: medicine.uses)
                    DetailRow(icon: "pills.fill", title: "Dosage", value: medicine.dosage)
                    DetailRow(icon: "exclamationmark.triangle.fill", title: "Warnings", value: medicine.warnings)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 5))
                .padding(.horizontal)

             
                VStack(spacing: 10) {
                    
                  
                    
                    
                }
                .padding(.top)
                
                Spacer()
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Medicine Details")
        .navigationBarTitleDisplayMode(.large)
    }
   
}


struct DetailRow: View {
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 18))
            Text("**\(title):** \(value)")
                .foregroundColor(.primary)
        }
    }
}


struct CustomButton: View {
    var title: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(radius: 3)
        }
        .padding(.horizontal)
        .animation(.spring(), value: title) 
    }
}

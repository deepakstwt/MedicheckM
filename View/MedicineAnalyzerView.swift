import SwiftUI

struct MedicineAnalyzerView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
              
                FeatureCard(title: "Scan Medicine Packages", description: "Use your camera to scan barcodes and instantly retrieve detailed medicine information.", icon: "barcode.viewfinder")
                
                FeatureCard(title: "Identify Active Ingredients", description: "Get a quick breakdown of a medicine's key ingredients and their effects.", icon: "capsule.fill")
                
                FeatureCard(title: "Check Expiry Dates", description: "Automatically check and track the expiration date of medicines to ensure safe consumption.", icon: "calendar.badge.exclamationmark")
                
                FeatureCard(title: "Verify Authenticity", description: "Detect counterfeit medicines by verifying barcodes and manufacturer details.", icon: "shield.lefthalf.filled")
                
                FeatureCard(title: "Personalized Warnings", description: "Receive alerts for potential drug interactions and precautions.", icon: "exclamationmark.triangle.fill")
            }
            .padding()
        }
        .navigationTitle("Medicine Package Analyzer")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                 
                }
                .foregroundColor(.blue)
            }
        }
    }
}


struct FeatureCard: View {
    var title: String
    var description: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline).bold()
                Text(description)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
    }
}


struct MedicineAnalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedicineAnalyzerView()
        }
    }
}

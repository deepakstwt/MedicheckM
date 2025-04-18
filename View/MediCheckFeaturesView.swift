import SwiftUI

struct MediCheckFeaturesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
         
                InfoCard(title: "Effortless Medicine Tracking", description: "Add medicines quickly using barcode scanning or manual entry.", systemImage: "pills.fill")
                
                InfoCard(title: "Smart Medication Reminders", description: "Stay on schedule with customized notifications for morning, afternoon, and night doses.", systemImage: "alarm.fill")
                
                InfoCard(title: "Expiry Date Alerts", description: "Get notified before medicines expire to avoid outdated consumption.", systemImage: "exclamationmark.triangle.fill")
                
                InfoCard(title: "Gamification & XP Rewards", description: "Earn XP, build streaks, and stay motivated to take medicines on time.", systemImage: "gamecontroller.fill")
                
                InfoCard(title: "Health Insights & Logs", description: "Track intake history and monitor medication habits over time.", systemImage: "chart.bar.fill")
                
                InfoCard(title: "Caregiver & Family Mode", description: "Manage medication reminders for loved ones and get shared alerts.", systemImage: "person.3.fill")
                
                InfoCard(title: "Offline & Data Security", description: "Works offline with full privacy—no unnecessary data collection.", systemImage: "lock.fill")
            }
            .padding()
        }
        .navigationTitle("MediCheck Features")
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




struct MediCheckFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MediCheckFeaturesView()
        }
    }
}

import SwiftUI

struct MediCheckOnboardingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
             
                InfoCard(title: "MediCheck", description: "Your personal medicine tracker ensuring you never miss a dose.", systemImage: "pills.fill")
                
          
                InfoCard(title: "Why?", description: "Many forget to take medicines or track expiry dates. MediCheck ensures timely intake and rewards consistency with XP-based gamification.", systemImage: "clock.fill")
                
             
                VStack(spacing: 12) {
                    TitleLabel(title: "How does it work?", systemImage: "barcode.viewfinder")
                    
                    VStack(spacing: 10) {
                        HowItWorksStep(stepNumber: "1", text: "Scan medicine barcodes", icon: "camera.fill")
                        HowItWorksStep(stepNumber: "2", text: "Set reminders", icon: "alarm.fill")
                        HowItWorksStep(stepNumber: "3", text: "Track expiry dates", icon: "calendar.badge.clock")
                        HowItWorksStep(stepNumber: "4", text: "Earn XP for staying consistent", icon: "target")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                }
                
    
                VStack(spacing: 12) {
                    TitleLabel(title: "Who is it for?", systemImage: "person.3.fill")
                    TargetAudienceList()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
            }
            .padding()
        }
        .navigationTitle("Getting Started")
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


struct InfoCard: View {
    var title: String
    var description: String
    var systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
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


struct TitleLabel: View {
    var title: String
    var systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.blue)
            Text(title)
                .font(.title2).bold()
        }
    }
}


struct HowItWorksStep: View {
    var stepNumber: String
    var text: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(stepNumber)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.blue))
            
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 22, height: 22)

            Text(text)
                .foregroundColor(.primary)
                .font(.body)
            
            Spacer()
        }
    }
}


struct TargetAudienceList: View {
    let audiences: [(icon: String, text: String)] = [
        ("person.fill", "Elderly individuals needing structured medicine intake."),
        ("heart.fill", "People managing chronic conditions."),
        ("hand.raised.fill", "Caregivers ensuring timely doses for loved ones."),
        ("leaf.fill", "Health-conscious individuals tracking supplements.")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(audiences, id: \.text) { audience in
                HStack {
                    Image(systemName: audience.icon)
                        .foregroundColor(.blue)
                        .font(.system(size: 20))

                    Text(audience.text)
                        .foregroundColor(.primary)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 8)
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
    }
}


struct MediCheckOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MediCheckOnboardingView()
        }
    }
}

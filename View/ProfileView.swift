import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
     
                Section(header: Text("INTRO").font(.caption).foregroundColor(.gray)) {
                    NavigationLink(destination: MediCheckOnboardingView()) {
                        ProfileRow(icon: "doc.text.fill", title: "Getting Started")
                    }
                    NavigationLink(destination: MediCheckFeaturesView()) {
                        ProfileRow(icon: "magnifyingglass.circle.fill", title: "MediCheck Features")
                    }
                }
                
               
                Section(header: Text("HEALTH CATEGORY").font(.caption).foregroundColor(.gray)) {
                    NavigationLink(destination: MedicineAnalyzerView()) {
                        ProfileRow(icon: "barcode.viewfinder", title: "Medicine Package Analyzer")
                    }
                }
                
            
                Section(header: Text("OUTRO").font(.caption).foregroundColor(.gray)) {
                   
                    NavigationLink(destination: AboutMeView()) {
                        ProfileRow(icon: "info.circle.fill", title: "About Me")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.orange)
                }
            }
        }
    }
}


struct ProfileRow: View {
    var icon: String
    var title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 30, height: 30)
            Text(title)
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

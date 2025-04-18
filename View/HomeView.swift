import SwiftUI

struct HomeView: View {
    @State private var showProfile = false 

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    MedicineStatusView()
                    LeaderboardView()
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("MediCheck")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

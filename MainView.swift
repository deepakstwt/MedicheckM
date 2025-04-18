import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            ScannerView()
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("Scan")
                }

            RemindersView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Reminders")
                }
        }
        .accentColor(.blue) 
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
             
                InfoCard(title: "MediCheck", description: "Your trusted medicine management companion, ensuring you never miss a dose and stay healthy.", systemImage: "cross.case.fill")
                
                
                InfoCard(title: "Developed By", description: "Deepak Prajapati, passionate iOS Developer and Swift enthusiast.", systemImage: "person.fill")
                
               
                InfoCard(title: "Our Mission", description: "To simplify medication tracking and ensure people stay on top of their health without hassle.", systemImage: "target")
                
          
                VStack(alignment: .leading, spacing: 10) {
                    Text("📬 Contact Us")
                        .font(.title2).bold()
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("deepakprajapatiproplus@gmail.com")
                            .foregroundColor(.primary)
                    }
                    
                  
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
                
            }
            .padding()
        }
        .navigationTitle("About Me")
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




struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutMeView()
        }
    }
}

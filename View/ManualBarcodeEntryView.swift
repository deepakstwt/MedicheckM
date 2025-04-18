import SwiftUI

struct ManualBarcodeEntryView: View {
    @Binding var enteredBarcode: String
    @Binding var scannedBarcode: String
    @Binding var medicineName: String
    @Binding var expiryDate: String
    let barcodeDatabase: [String: (String, String)]

    @Environment(\.presentationMode) var presentationMode
    @State private var showConfetti = false
    @State private var showError = false
    @State private var xpPoints = 750
    @State private var isTyping = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray5).edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                   
                    HStack {
                        Text("🔥 15-Day Streak | \(xpPoints) XP")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

               
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "barcode.viewfinder")
                                .foregroundColor(.blue)
                            Text("Enter Barcode")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                        }

                       
                        TextField("Enter Barcode", text: $enteredBarcode, onEditingChanged: { typing in
                            isTyping = typing
                        })
                        .padding()
                        .background(isTyping ? Color.blue.opacity(0.2) : Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isTyping ? Color.blue : Color.clear, lineWidth: 1)
                        )
                        .animation(.easeInOut(duration: 0.3), value: isTyping)

                      
                        if !medicineName.isEmpty {
                            VStack(spacing: 5) {
                                Text("💊 Medicine: \(medicineName)")
                                    .font(.headline)
                                Text(expiryDate)
                                    .foregroundColor(expiryDate.contains("Expired") ? .red : .green)

                                if showConfetti {
                                    Text("🎉 +50 XP for Identifying Medicine!")
                                        .font(.subheadline)
                                        .foregroundColor(.orange)
                                        .transition(.opacity)
                                }

                                if showError {
                                    Text("❌ Not Found! Try Again.")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                        .transition(.opacity)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal)

        
                    Button(action: fetchMedicineDetails) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .scaleEffect(showConfetti ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: showConfetti)
                    }
                    .padding(.horizontal)

                    Spacer()
                }

          
                if showConfetti {
                    ConfettiView()
                        .transition(.scale)
                        .animation(.spring())
                }
            }
            .navigationBarTitle("Enter Barcode", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red),
                
                trailing: Button("Add") {
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.green)
            )
        }
    }

 
    func fetchMedicineDetails() {
        scannedBarcode = enteredBarcode
        if let details = barcodeDatabase[enteredBarcode] {
            medicineName = details.0
            expiryDate = details.1
            showConfetti = true
            showError = false
            xpPoints += 50
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showConfetti = false
            }
        } else {
            medicineName = "Unknown Medicine"
            expiryDate = "Expiry Not Found"
            showConfetti = false
            showError = true
        }
    }
}

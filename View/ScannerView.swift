import SwiftUI

struct ScannerView: View {
    @State private var isScanning = false
    @State private var scannedBarcode: String = ""
    @State private var medicineName: String = ""
    @State private var expiryDate: String = ""
    @State private var showManualEntry = false
    @State private var enteredBarcode: String = ""

    let barcodeDatabase: [String: (String, String)] = [
        "8901234567890": ("Paracetamol 650mg", "Expires in 3 months"),
        "8909876543210": ("Ibuprofen 400mg", "Expires in 7 days"),
        "8901112131415": ("Amoxicillin 500mg", "Expires in 2 days")
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Scan Your Medicine")
                .font(.system(size: 26, weight: .bold))
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 220, height: 220)

                if isScanning {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Image(systemName: "barcode.viewfinder")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                }
            }

         
            Button(action: startScanning) {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                    Text(isScanning ? "Scanning..." : "Start Scan")
                        .fontWeight(.bold)
                }
                .padding()
                .frame(width: 200)
                .background(isScanning ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 3)
            }
            .disabled(isScanning)

        
            Group {
                if !scannedBarcode.isEmpty {
                    VStack {
                        Text("Scanned Barcode:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(scannedBarcode)
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 10)
                }
                
                if !medicineName.isEmpty {
                    VStack {
                        HStack {
                            Text("💊 Medicine: \(medicineName)")
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        Text(expiryDate)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .frame(width: 280)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
                }
            }
            .frame(height: 80)
            
 
            Button(action: { showManualEntry = true }) {
                Text("Enter Barcode Manually")
                    .padding()
                    .frame(width: 220)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
            }
            .sheet(isPresented: $showManualEntry) {
                ManualBarcodeEntryView(
                    enteredBarcode: $enteredBarcode,
                    scannedBarcode: $scannedBarcode,
                    medicineName: $medicineName,
                    expiryDate: $expiryDate,
                    barcodeDatabase: barcodeDatabase
                )
            }
        }
        .padding()
    }

    func startScanning() {
        isScanning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            scannedBarcode = "8909876543210"
            if let details = barcodeDatabase[scannedBarcode] {
                medicineName = details.0
                expiryDate = details.1
            }
            isScanning = false
        }
    }
}

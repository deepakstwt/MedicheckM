import SwiftUI


struct Reminder: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let icon: String
    let color: Color
    var tasks: [String] = []
}


enum ReminderCategory: String, CaseIterable {
    case todayDoses = "Today's Doses & Tasks"
    case plannedMeds = "Planned Medications"
    case missedDoses = "Missed Doses (Catch Up)"
    case activeTreatments = "Active Treatments"
    case healthHistory = "Health History"
}


struct RemindersView: View {
    @State private var reminders: [Reminder] = [
     
        Reminder(title: "Take Vitamin C", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, icon: "pills.fill", color: .orange, tasks: ["Morning Dose", "Evening Dose"]),
        Reminder(title: "Blood Pressure Check", date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, icon: "heart.fill", color: .red, tasks: ["Check BP before food"]),
        
   
        Reminder(title: "Doctor's Appointment", date: Calendar.current.date(byAdding: .day, value: 15, to: Date())!, icon: "stethoscope", color: .purple),
        Reminder(title: "Allergy Medication", date: Calendar.current.date(byAdding: .month, value: 1, to: Date())!, icon: "allergens.fill", color: .cyan),
        
        //  Active Treatments
        Reminder(title: "Physiotherapy Session", date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, icon: "figure.walk", color: .green),
        Reminder(title: "Diabetes Checkup", date: Calendar.current.date(byAdding: .month, value: 2, to: Date())!, icon: "drop.fill", color: .blue),

        //  Missed Doses
        Reminder(title: "Missed Vitamin D", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, icon: "exclamationmark.triangle.fill", color: .yellow),
        
        //  Health History (Previously Taken Medications)
        Reminder(title: "Flu Medication", date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!, icon: "cross.case.fill", color: .gray)
    ]
    
    @State private var showAddReminder = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    // 🗂️ **Categorized Sections**
                    ForEach(ReminderCategory.allCases, id: \.self) { category in
                        let filteredReminders = reminders.filter { getCategory(for: $0.date) == category }
                        
                        if !filteredReminders.isEmpty {
                            VStack(alignment: .leading, spacing: 15) {
                                // Section Header
                                Text(category.rawValue)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(spacing: 10) {
                                    ForEach(filteredReminders) { reminder in
                                        NavigationLink(destination: ReminderDetailView(reminder: reminder)) {
                                            ReminderCard(reminder: reminder)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Medicine Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddReminder = true }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showAddReminder) {
                AddReminderView(reminders: $reminders)
            }
        }
    }

    private func getCategory(for date: Date) -> ReminderCategory {
        let today = Date()
        let calendar = Calendar.current
        let daysBetween = calendar.dateComponents([.day], from: today, to: date).day ?? 0

        switch daysBetween {
        case 0...6: return .todayDoses
        case 7...30: return .plannedMeds
        case -7..<0: return .missedDoses
        case let x where x < -7: return .healthHistory
        default: return .activeTreatments
        }
    }
}

//  **Updated Reminder Card**
struct ReminderCard: View {
    let reminder: Reminder
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [reminder.color.opacity(0.6), reminder.color], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 50, height: 50)
                
                Image(systemName: reminder.icon)
                    .foregroundColor(.white)
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(reminder.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(formattedDate(reminder.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
                .font(.system(size: 18))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white).shadow(radius: 3))
        .padding(.horizontal, 5)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

//  **Add Reminder View**
struct AddReminderView: View {
    @Binding var reminders: [Reminder]
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var selectedDate = Date()
    @State private var selectedIcon = "pills.fill"
    
    let icons = ["pills.fill", "heart.fill", "figure.walk", "stethoscope", "allergens.fill", "drop.fill", "cross.case.fill", "exclamationmark.triangle.fill"]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Reminder Details")) {
                        TextField("Reminder Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        DatePicker("Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.compact)
                    }
                    
                    Section(header: Text("Choose an Icon")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(icons, id: \.self) { icon in
                                    Button(action: {
                                        selectedIcon = icon
                                    }) {
                                        Image(systemName: icon)
                                            .font(.title2)
                                            .padding()
                                            .background(selectedIcon == icon ? Color.blue.opacity(0.2) : Color.clear)
                                            .clipShape(Circle())
                                    }
                                    .padding(.horizontal, 5)
                                }
                            }
                        }
                    }
                }
                
                Button(action: saveReminder) {
                    Label("Save Reminder", systemImage: "checkmark.circle.fill")
                }
                .disabled(title.isEmpty)
            }
            .navigationTitle("Add Reminder")
        }
    }

    func saveReminder() {
        let newReminder = Reminder(title: title, date: selectedDate, icon: selectedIcon, color: .blue)
        reminders.append(newReminder)
        presentationMode.wrappedValue.dismiss()
    }
}

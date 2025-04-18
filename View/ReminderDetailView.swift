import SwiftUI

struct ReminderDetailView: View {
    var reminder: Reminder
    @State private var tasks: [TaskItem] = []
    @State private var newTask = ""

    struct TaskItem: Identifiable {
        let id = UUID()
        var title: String
        var isCompleted: Bool = false
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
     
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        Image(systemName: reminder.icon)
                            .foregroundColor(reminder.color)
                            .font(.largeTitle)
                            .padding(10)
                            .background(reminder.color.opacity(0.15))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(reminder.title)
                                .font(.title2)
                                .bold()
                            
                            Text(formattedDate(reminder.date))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
                
            
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Tasks")
                        .font(.headline)
                        .padding(.leading, 5)
                    
                    VStack(spacing: 12) {
                       
                        ForEach(tasks.indices, id: \.self) { index in
                            HStack {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        tasks[index].isCompleted.toggle()
                                    }
                                }) {
                                    Image(systemName: tasks[index].isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(tasks[index].isCompleted ? .green : .gray)
                                        .font(.title2)
                                        .padding(.trailing, 5)
                                }
                                .buttonStyle(PlainButtonStyle())

                                Text(tasks[index].title)
                                    .strikethrough(tasks[index].isCompleted, color: .gray)
                                    .foregroundColor(tasks[index].isCompleted ? .gray : .black)
                                    .font(.body)

                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .onDelete(perform: deleteTask)
                        
                    
                        if !tasks.isEmpty {
                            Divider()
                                .padding(.vertical, 8)
                        }

             
                        HStack {
                            TextField("New Task", text: $newTask)
                                .padding(14)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .disableAutocorrection(true)

                            Button(action: addTask) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Reminder Details")
        .onAppear {
            self.tasks = reminder.tasks.map { TaskItem(title: $0) }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

   
    func addTask() {
        guard !newTask.isEmpty else { return }
        withAnimation(.spring()) {
            tasks.append(TaskItem(title: newTask))
        }
        newTask = ""
    }


    func deleteTask(at offsets: IndexSet) {
        withAnimation(.easeOut) {
            tasks.remove(atOffsets: offsets)
        }
    }
}

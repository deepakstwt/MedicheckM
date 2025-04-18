import UserNotifications

class NotificationManager {
    @MainActor static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }

    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(reminder.title)"
        content.body = "It's time for \(reminder.title)!"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminder.date),
            repeats: false
        )

        let request = UNNotificationRequest(identifier: reminder.title, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

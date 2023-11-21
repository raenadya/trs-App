//
//  NotificationManager.swift
//  trs App
//
//  Created by Tristan Chay on 21/11/23.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared: NotificationManager = .init()
    
    init() {
        requestPermission()
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addNotification(uuid: UUID, title: String, subtitle: String, startDate: Date) {
        let content = UNMutableNotificationContent()
        content.subtitle = title
        content.body = subtitle
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: startDate.timeIntervalSinceNow - 1800, repeats: false)
        let request = UNNotificationRequest(identifier: uuid.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func removePendingNotifications(uuids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuids)
    }
    
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

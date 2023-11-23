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
    
    @AppStorage("notifyBeforeEvent") private var notifyBeforeEvent = true
    @AppStorage("notifyAfterEvent") private var notifyAfterEvent = true
    
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
    
    func addNotifications(uuid: UUID, startTitle: String, startBody: String, endTitle: String, endBody: String, startDate: Date, endDate: Date) {
        self.addStartNotification(uuid: uuid, title: startTitle, body: startBody, startDate: startDate)
        self.addEndNotification(uuid: uuid, title: endTitle, body: endBody, endDate: endDate)
    }
    
    func addStartNotification(uuid: UUID, title: String, body: String, startDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        if (startDate.timeIntervalSinceNow - 1800) > 0 {
            let startTrigger = UNTimeIntervalNotificationTrigger(timeInterval: startDate.timeIntervalSinceNow - 1800, repeats: false)
            let startRequest = UNNotificationRequest(identifier: "\(uuid.uuidString)S", content: content, trigger: startTrigger)
            UNUserNotificationCenter.current().add(startRequest)
        }
    }
    
    func addEndNotification(uuid: UUID, title: String, body: String, endDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        if endDate.timeIntervalSinceNow > 0 {
            let endTrigger = UNTimeIntervalNotificationTrigger(timeInterval: endDate.timeIntervalSinceNow, repeats: false)
            let endRequest = UNNotificationRequest(identifier: "\(uuid.uuidString)E", content: content, trigger: endTrigger)
            UNUserNotificationCenter.current().add(endRequest)
        }
    }
    
    enum PendingNotificationRemovalType {
        case before, after, both
    }
    
    func removeNotifications(uuids: [String], for type: PendingNotificationRemovalType) {
        switch type {
        case .before:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuids.map { "\($0)S" })
        case .after:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuids.map { "\($0)E" })
        case .both:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuids.map { "\($0)S" })
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: uuids.map { "\($0)E" })
        }
    }
    
//    func removeAll() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//    }
//    
//    func fetch() {
//        UNUserNotificationCenter.current().getPendingNotificationRequests { notifs in
//            notifs.forEach { notif in
//                print(notif.identifier)
//            }
//        }
//    }
}

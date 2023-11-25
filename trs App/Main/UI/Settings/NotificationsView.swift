//
//  NotificationsView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/20.
//

import SwiftUI

struct NotificationsView: View {
    
    @AppStorage("notifyBeforeEvent") private var notifyBeforeEvent = true
    @AppStorage("notifyAfterEvent") private var notifyAfterEvent = true
    
    @ObservedObject var seManager: ScheduleEventManager = .shared
    @ObservedObject var notificationManager: NotificationManager = .shared
    
    var body: some View {
        List {
            Section {
                Toggle("Notify Before Event", isOn: $notifyBeforeEvent)
                Toggle("Notify After Event", isOn: $notifyAfterEvent)
            } footer: {
                Text("A notification will be sent 30 minutes before your event starts, and as soon as your event ends.")
            }
        }
        .navigationTitle("Notifications")
        .onChange(of: notifyBeforeEvent) { newValue in
            onChangeOfNotifyBeforeEvent(newValue)
        }
        .onChange(of: notifyAfterEvent) { newValue in
            onChangeOfNotifyAfterEvent(newValue)
        }
    }
    
    func onChangeOfNotifyBeforeEvent(_ newValue: Bool) {
        if newValue == false {
            var uuids: [String] = []
            seManager.scheduledEvents.forEach { uuids.append($0.id.uuidString) }
            notificationManager.removeNotifications(uuids: uuids, for: .before)
        } else {
            seManager.scheduledEvents.forEach { event in
                notificationManager.addStartNotification(
                    uuid: event.id,
                    title: "\(event.eventName)",
                    body: "The event \(event.eventName) organised by \(event.organiserName) starts in 30 minutes.",
                    startDate: event.startDate
                )
            }
        }
    }
    
    func onChangeOfNotifyAfterEvent(_ newValue: Bool) {
        if newValue == false {
            var uuids: [String] = []
            seManager.scheduledEvents.forEach { uuids.append($0.id.uuidString) }
            notificationManager.removeNotifications(uuids: uuids, for: .after)
        } else {
            seManager.scheduledEvents.forEach { event in
                notificationManager.addEndNotification(
                    uuid: event.id,
                    title: "\(event.eventName)",
                    body: "Add any achievements or credentials you've attained during this event into your portfolio.",
                    endDate: event.endDate
                )
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

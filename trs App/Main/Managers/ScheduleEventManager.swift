//
//  ScheduleEventManager.swift
//  trs App
//
//  Created by Tristan Chay on 21/11/23.
//

import SwiftUI
import SwiftPersistence

struct Event: Identifiable, Codable {
    var id = UUID()
    var eventName: String
    var organiserName: String
    var description: String?
    var startDate: Date
    var endDate: Date
}

class ScheduleEventManager: ObservableObject {
    static let shared: ScheduleEventManager = .init()
    
    @Persistent("scheduledEvents") private var internalScheduledEvents: [Event] = []
    
    @Published var scheduledEvents: [Event] = []
    @ObservedObject var notificationManager: NotificationManager = .shared
    
    init() {
        updatePublishedVariables()
    }
    
    func updatePublishedVariables() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.scheduledEvents = self.internalScheduledEvents
        }
    }
    
    func addToScheduledEvents(withValue event: Event) {
        notificationManager.addNotifications(
            uuid: event.id,
            startTitle: "\(event.eventName)",
            startBody: "The event \(event.eventName) organised by \(event.organiserName) starts in 30 minutes.",
            endTitle: "\(event.eventName)",
            endBody: "Add any achievements or credentials you've attained during this event into your portfolio.",
            startDate: event.startDate,
            endDate: event.endDate
        )
        internalScheduledEvents.insert(event, at: 0)
        updatePublishedVariables()
    }
    
    func removeScheduledEvent(atOffset index: IndexSet) {
        var uuids: [String] = []
        index.forEach { uuids.append(self.scheduledEvents[$0].id.uuidString) }
        notificationManager.removeNotifications(uuids: uuids, for: .both)
        internalScheduledEvents.remove(atOffsets: index)
        updatePublishedVariables()
    }
}

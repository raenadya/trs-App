//
//  NewEventView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/18.
//

import SwiftUI
import SwiftPersistence

struct NewEventView: View {
    
    @State var eventName = ""
    @State var organiserName = ""
    @State var description = ""
    @State var startDate = Date()
    @State var endDate = Date()
    
    var disabled: Bool {
        if !eventName.isEmpty && !organiserName.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    @Environment(\.dismiss) var dismiss
    
    @Persistent("scheduledEvents") var scheduledEvents: [Event] = []
    
    @ObservedObject var seManager: ScheduleEventManager = .shared
    @ObservedObject var notificationManager: NotificationManager = .shared
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Information *") {
                        TextField("Event Name",
                                  text: $eventName)
                        TextField("Organiser Name", text: $organiserName)
                    }
                    
                    Section("Dates *") {
                        DatePicker(selection: $startDate, in: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10)...endDate, displayedComponents: [.date, .hourAndMinute]) {
                            Text("Start Date")
                        }
                        
                        DatePicker(selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute]) {
                            Text("End Date")
                        }
                    }
                    
                    Section {
                        TextField("Description", text: $description, axis: .vertical)
                    } header: {
                        Text("Description")
                    } footer: {
                        Text("Add a short description if needed.")
                    }
                }
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement:. navigationBarTrailing) {
                    Button {
                        let eventUUID = UUID()
                        seManager.addToScheduledEvents(
                            withValue: Event(id: eventUUID,
                                             eventName: eventName,
                                             organiserName: organiserName,
                                             description: description,
                                             startDate: startDate,
                                             endDate: endDate)
                        )
                        notificationManager.addNotifications(
                            uuid: eventUUID,
                            startTitle: "\(eventName)",
                            startBody: "The event \(eventName) organised by \(organiserName) starts in 30 minutes.",
                            endTitle: "\(eventName)",
                            endBody: "Add any achievements or credentials you've attained during this event into your portfolio.",
                            startDate: startDate,
                            endDate: endDate
                        )
                        dismiss.callAsFunction()
                    } label: {
                        Text("Add")
                    }
                    .disabled(disabled)
                }
            }
        }
    }
}


struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView ()
    }
}

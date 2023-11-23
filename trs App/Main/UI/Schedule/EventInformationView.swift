//
//  EventInformationView.swift
//  trs App
//
//  Created by Tristan Chay on 21/11/23.
//

import SwiftUI
import SwiftPersistence

struct EventInformationView: View {
    
    @State var event: Event
    
    @State var eventName = ""
    @State var organiserName = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description = ""
    
    @Environment(\.editMode) var editMode
    
    @ObservedObject var seManager: ScheduleEventManager = .shared
    @ObservedObject var notificationManager: NotificationManager = .shared
    
    @Persistent("scheduledEvents") var scheduledEvents: [Event] = []
    
    var body: some View {
        List {
            Section("Information") {
                if editMode?.wrappedValue.isEditing == false {
                    Text(eventName)
                    Text(organiserName)
                } else {
                    TextField("Event Name", text: $eventName)
                    TextField("Organiser Name", text: $organiserName)
                }
            }
            
            Section("Dates") {
                if editMode?.wrappedValue.isEditing == false {
                    HStack {
                        Text("Start Date")
                        Spacer()
                        Text(startDate, format: .dateTime.day().month().year().hour().minute())
                    }
                    
                    HStack {
                        Text("End Date")
                        Spacer()
                        Text(endDate, format: .dateTime.day().month().year().hour().minute())
                    }
                } else {
                    DatePicker(selection: $startDate, in: ...endDate, displayedComponents: [.date, .hourAndMinute]) {
                        Text("Start Date")
                    }
                    
                    DatePicker(selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute]) {
                        Text("End Date")
                    }
                }
            }
            
            if editMode?.wrappedValue.isEditing == false {
                if !description.isEmpty && description != " " {
                    Section("Description") {
                        Text(description)
                    }
                }
            } else {
                Section("Description") {
                    TextField("Description", text: $description)
                }
            }
        }
        .navigationTitle(eventName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onChange(of: editMode?.wrappedValue.isEditing) { newValue in
            if newValue == false {
                let index = scheduledEvents.firstIndex { $0.id == event.id }
                guard let index = index else { return }
                let newEvent = Event(id: event.id,
                                     eventName: eventName,
                                     organiserName: organiserName,
                                     description: description,
                                     startDate: startDate,
                                     endDate: endDate)
                scheduledEvents[index] = newEvent
                notificationManager.editNotification(newEvent: newEvent)
                seManager.updatePublishedVariables()
            }
        }
        .onAppear {
            eventName = event.eventName
            organiserName = event.organiserName
            startDate = event.startDate
            endDate = event.endDate
            description = event.description ?? ""
        }
    }
}

//struct EventInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventInformationView()
//    }
//}

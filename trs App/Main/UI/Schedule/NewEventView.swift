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
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Information *") {
                        TextField("Event Name", text: $eventName)
                        TextField("Organiser Name", text: $organiserName)
                    }
                    
                    Section("Dates *") {
                        DatePicker(selection: $startDate, in: ...endDate, displayedComponents: [.date, .hourAndMinute]) {
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
                        seManager.addToScheduledEvents(
                            withValue: Event(eventName: eventName,
                                             organiserName: organiserName,
                                             description: description,
                                             startDate: startDate,
                                             endDate: endDate)
                        )
                        dismiss.callAsFunction()
                    } label: {
                        Text("Add")
                    }
                    .disabled(disabled)
                }
            }
            .onAppear {
                let calendar = Calendar(identifier: .gregorian)
                startDate = calendar.startOfDay(for: Date())
                endDate = calendar.startOfDay(for: Date())
            }
        }
    }
}


struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView ()
    }
}

//
//  ScheduleView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct ScheduleView: View {
    
    @State private var showingNewEventView = false
    
    @ObservedObject var seManager: ScheduleEventManager = .shared
        
    var body: some View {
        NavigationStack {
            VStack {
                if !seManager.scheduledEvents.isEmpty {
                    List {
                        Section("Upcoming Events") {
                            ForEach(seManager.scheduledEvents) { event in
                                VStack(alignment: .leading) {
                                    Text(event.eventName)
                                        .fontWeight(.bold)
                                    if let description = event.description, !description.isEmpty, description != " " {
                                        Text(description)
                                            .lineLimit(2)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .onDelete { index in
                                seManager.removeScheduledEvent(atOffset: index)
                            }
                        }
                    }
                } else {
                    Text("Schedule your events and receive a notification to remind you to update your portfolio here!")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewEventView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            
        }
        .sheet(isPresented: $showingNewEventView) {
            NewEventView()
        }
    }
}




struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

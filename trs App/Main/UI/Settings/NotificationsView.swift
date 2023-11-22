//
//  NotificationsView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/20.
//

import SwiftUI

struct NotificationsView: View {
    
    @AppStorage("notifyBeforeCompetition") private var notifyBeforeCompetition = true
    @AppStorage("notifyAfterCompeition") private var notifyAfterCompeition = true
    
    var body: some View {
        List {
            Section {
                Toggle("Notify Before Competition", isOn: $notifyBeforeCompetition)
                Toggle("Notify After Competition", isOn: $notifyAfterCompeition)
            }
        }
        .navigationTitle("Notifications")
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
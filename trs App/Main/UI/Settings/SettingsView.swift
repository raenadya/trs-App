//
//  SettingsView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Account")
                Text("Notifications")
                Text("Appearance")
                Text("Privacy & Security")
                Text("Help & Support")
                Text("Acknowledgements")
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

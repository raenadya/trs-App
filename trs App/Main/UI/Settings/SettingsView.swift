//
//  SettingsView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showingAvatarView = false
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AvatarView()
                    } label: {
                        Label("Avatar", systemImage: "person.circle")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

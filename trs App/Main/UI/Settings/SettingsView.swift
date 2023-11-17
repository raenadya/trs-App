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
            .toolbar{
                ToolbarItem{
                    Button {
                        self.showingAvatarView = true
                        } label: {
                        Label("Avatar", systemImage: "person.circle")
                    }
                }
            }
            NavigationLink(destination: AvatarView(), isActive: $showingAvatarView) { EmptyView() }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

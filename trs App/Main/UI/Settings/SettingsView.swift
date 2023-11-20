//
//  SettingsView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showingAvatarView = false
    
    @State var alertHeader = ""
    @State var alertMessage = ""
    @State var showingAlert = false
    
    @State var showingSignOutAlert = false
    @ObservedObject var authManager: AuthenticationManager = .shared
    
    var body: some View {
        NavigationStack {
            List {
                
                NavigationLink(destination: AccountView()) {
                    Text("Account")
                }
                
                NavigationLink(destination:NotificationView()){
                    Text("Notifications")
                }
                
                signOutButton
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
    
    var signOutButton: some View {
        Section {
            Button {
                showingSignOutAlert = true
            } label: {
                Text("Sign out")
            }
            .tint(.red)
            .alert("Sign out", isPresented: $showingSignOutAlert) {
                Button(role: .destructive) {
                    authManager.signOut() { result in
                        switch result {
                        case .success(_):
                            break
                        case .failure(let failure):
                            alertHeader = "Error"
                            alertMessage = "\(failure.localizedDescription)"
                            showingAlert = true
                        }
                    }
                } label: {
                    Text("Sign out")
                }
            } message: {
                Text("Are you sure you want to sign out? You can always sign back in with your email and password.")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

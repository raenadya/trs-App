//
//  ContentView.swift
//  trs App
//
//  Created by Kierae NJ on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authManager: AuthenticationManager = .shared
    
    var body: some View {
        if authManager.isLoggedIn {
            TabView {
                PortfolioView()
                    .tabItem {
                        Label("My Portfolio", systemImage: "book.pages.fill")
                    }
                ScheduleView()
                    .tabItem {
                        Label("Schedule", systemImage: "calendar")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        } else {
            AuthenticationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

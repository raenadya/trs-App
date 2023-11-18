//
//  PortfolioView.swift
//  trs App
//
//  Created by Tristan Chay on 16/11/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @State var showingAddCredentialView = false
    
    @ObservedObject var filterManager: FilterManager = .shared
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    
    var body: some View {
        NavigationStack {
            list
                .safeAreaInset(edge: .top) {
                    FilterButtons()
                }
                .navigationTitle("My Portfolio")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if filterManager.currentSelection != .all {
                            EditButton()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddCredentialView.toggle()
                        } label: {
                            Label("Add credential", systemImage: "plus")
                        }
                    }
                }
        }
        .sheet(isPresented: $showingAddCredentialView) {
            CategoriesView()
        }
    }
    
    var list: some View {
        List {
            switch filterManager.currentSelection {
            case .all:
                ForEach(credentials, id: \.id) { credential in
                    switch credential {
                    case .achievementAndHonour(let achievementAndHonour):
                        Text(achievementAndHonour.title)
                    case .competition(let competition):
                        Text(competition.title)
                    case .experience(let experience):
                        Text(experience.title)
                    case .project(let project):
                        Text(project.title)
                    }
                }
            case .experiences:
                ForEach(credentialsManager.experiences, id: \.id) { experience in
                    Text(experience.title)
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .experiences, atOffset: indexOffset)
                }
            case .competitions:
                ForEach(credentialsManager.competitions, id: \.id) { competition in
                    Text(competition.title)
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .competitions, atOffset: indexOffset)
                }
            case .achievementsAndHonours:
                ForEach(credentialsManager.achievementAndHonours, id: \.id) { achievementAndHonour in
                    Text(achievementAndHonour.title)
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .achievementsAndHonours, atOffset: indexOffset)
                }
            case .projects:
                ForEach(credentialsManager.projects, id: \.id) { project in
                    Text(project.title)
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .projects, atOffset: indexOffset)
                }
            }
        }
    }
    
    var credentials: [Credential] {
        var credentials = credentialsManager.achievementAndHonours.map { Credential.achievementAndHonour($0) } +
        credentialsManager.experiences.map { Credential.experience($0) } +
        credentialsManager.competitions.map { Credential.competition($0) } +
        credentialsManager.projects.map { Credential.project($0) }
        credentials.sort(by: { $0.dateAdded > $1.dateAdded })
        return credentials
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

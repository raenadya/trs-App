//
//  PortfolioView.swift
//  trs App
//
//  Created by Tristan Chay on 16/11/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @State var showingAddCredentialView = false
    @State var showingTipsView = false
    
    @ObservedObject var filterManager: FilterManager = .shared
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    
    @State var coinNumber = 0
    
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
                            showingTipsView.toggle()
                        } label: {
                            Label("Open Tips", systemImage: "lightbulb")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddCredentialView.toggle()
                        } label: {
                            Label("Add credential", systemImage: "plus")
                        }
                    }
                    
                    ToolbarItem(placement:.navigationBarTrailing){
                        
                        Text("\(coinNumber) 🪙")
                            .padding()
                            .bold()
                            .foregroundColor(.purple)
                            
                    }
                }
        }
        .sheet(isPresented: $showingAddCredentialView) {
            CategoriesView(showingAddCredentialView: $showingAddCredentialView)
        }
        .sheet(isPresented: $showingTipsView) {
            TipsView(currentSelection: filterManager.currentSelection)
                .presentationDetents([.medium])
        }
    }
    
    var list: some View {
        List {
            switch filterManager.currentSelection {
            case .all:
                ForEach(credentials, id: \.id) { credential in
                    switch credential {
                    case .achievementAndHonour(let achievementAndHonour):
                        NavigationLink {
                            CredentialInformationView(credential: Credential.achievementAndHonour(achievementAndHonour))
                        } label: {
                            listRowPreview(title: achievementAndHonour.title, description: achievementAndHonour.description)
                        }
                    case .competition(let competition):
                        NavigationLink {
                            CredentialInformationView(credential: Credential.competition(competition))
                        } label: {
                            listRowPreview(title: competition.title, description: competition.description)
                        }
                    case .experience(let experience):
                        NavigationLink {
                            CredentialInformationView(credential: Credential.experience(experience))
                        } label: {
                            listRowPreview(title: experience.title, description: experience.description)
                        }
                    case .project(let project):
                        NavigationLink {
                            CredentialInformationView(credential: Credential.project(project))
                        } label: {
                            listRowPreview(title: project.title, description: project.description)
                        }
                    }
                }
            case .experiences:
                ForEach(credentialsManager.experiences, id: \.id) { experience in
                    NavigationLink {
                        CredentialInformationView(credential: Credential.experience(experience))
                    } label: {
                        listRowPreview(title: experience.title, description: experience.description)
                    }
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .experiences, atOffset: indexOffset)
                }
            case .competitions:
                ForEach(credentialsManager.competitions, id: \.id) { competition in
                    NavigationLink {
                        CredentialInformationView(credential: Credential.competition(competition))
                    } label: {
                        listRowPreview(title: competition.title, description: competition.achievementLevel)
                    }
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .competitions, atOffset: indexOffset)
                }
            case .achievementsAndHonours:
                ForEach(credentialsManager.achievementAndHonours, id: \.id) { achievementAndHonour in
                    NavigationLink {
                        CredentialInformationView(credential: Credential.achievementAndHonour(achievementAndHonour))
                    } label: {
                        listRowPreview(title: achievementAndHonour.title, description: achievementAndHonour.achievementLevel)
                    }
                }
                .onDelete { indexOffset in
                    credentialsManager.removeCredential(forType: .achievementsAndHonours, atOffset: indexOffset)
                }
            case .projects:
                ForEach(credentialsManager.projects, id: \.id) { project in
                    NavigationLink {
                        CredentialInformationView(credential: Credential.project(project))
                    } label: {
                        listRowPreview(title: project.title, description: project.description)
                    }
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
    
    @ViewBuilder
    func listRowPreview(title: String, description: String?) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            if let description = description, !description.isEmpty && description != " " {
                Text(description)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

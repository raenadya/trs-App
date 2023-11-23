//
//  PortfolioView.swift
//  trs App
//
//  Created by Tristan Chay on 16/11/23.
//

import SwiftUI

struct PortfolioView: View {
    
    enum PortfolioListSortType: String, CaseIterable {
        case noSort = "None"
        case category = "Category"
        case importance = "Importance"
    }
    
    @State var showingAddCredentialView = false
    @State var showingTipsView = false
    
    @ObservedObject var filterManager: FilterManager = .shared
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    
    @State var coinNumber = 0
    
    @State var sortSelection: PortfolioListSortType = .noSort
    
    var showSortPicker: Bool {
        switch filterManager.currentSelection {
        case .all:
            if sortedCredentials.count > 0 { 
                return true
            } else {
                return false
            }
        case .experiences:
            if experiences.count > 0 {
                return true
            } else {
                return false
            }
        case .competitions:
            if competitions.count > 0 {
                return true
            } else {
                return false
            }
        case .achievementsAndHonours:
            if achievementsAndHonours.count > 0 {
                return true
            } else {
                return false
            }
        case .projects:
            if projects.count > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
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
                    
                    ToolbarItem(placement:.navigationBarLeading){
                        Text("\(coinNumber) coins")
                            .bold()
                            .underline()
                            .foregroundColor(.purple)
                        CoinSystemView()  
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
        .onChange(of: filterManager.currentSelection) { newValue in
            if newValue != .all && sortSelection == .category {
                sortSelection = .noSort
            }
        }
    }
    
    var list: some View {
        List {
            Section {
                switch filterManager.currentSelection {
                case .all:
                    allCategories
                case .experiences:
                    experiencesCategory
                case .competitions:
                    competitionsCategory
                case .achievementsAndHonours:
                    achievementsAndHonoursCategory
                case .projects:
                    projectsCategory
                }
            } header: {
                if showSortPicker {
                    sortPicker
                }
            }
        }
    }
    
    var sortPicker: some View {
        HStack {
            Spacer()
            Picker("Filter", selection: $sortSelection) {
                ForEach(PortfolioListSortType.allCases, id: \.rawValue) { filter in
                    if filter != .category {
                        Text(filter.rawValue)
                            .tag(filter)
                        if filter == .noSort {
                            Divider()
                        }
                    } else if filter == .category && filterManager.currentSelection == .all {
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
            }
        }
        .textCase(nil)
    }
    
    var allCategories: some View {
        ForEach(sortedCredentials, id: \.id) { credential in
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
    }
    
    var experiencesCategory: some View {
        ForEach(experiences, id: \.id) { experience in
            NavigationLink {
                CredentialInformationView(credential: Credential.experience(experience))
            } label: {
                listRowPreview(title: experience.title, description: experience.description)
            }
        }
        .onDelete { indexOffset in
            credentialsManager.removeCredential(forType: .experiences, atOffset: indexOffset)
        }
    }
    
    var competitionsCategory: some View {
        ForEach(competitions, id: \.id) { competition in
            NavigationLink {
                CredentialInformationView(credential: Credential.competition(competition))
            } label: {
                listRowPreview(title: competition.title, description: competition.description)
            }
        }
        .onDelete { indexOffset in
            credentialsManager.removeCredential(forType: .competitions, atOffset: indexOffset)
        }
    }
    
    var achievementsAndHonoursCategory: some View {
        ForEach(achievementsAndHonours, id: \.id) { achievementAndHonour in
            NavigationLink {
                CredentialInformationView(credential: Credential.achievementAndHonour(achievementAndHonour))
            } label: {
                listRowPreview(title: achievementAndHonour.title, description: achievementAndHonour.description)
            }
        }
        .onDelete { indexOffset in
            credentialsManager.removeCredential(forType: .achievementsAndHonours, atOffset: indexOffset)
        }
    }
    
    var projectsCategory: some View {
        ForEach(projects, id: \.id) { project in
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
    
    var credentials: [Credential] {
        var credentials = credentialsManager.achievementAndHonours.map { Credential.achievementAndHonour($0) } +
        credentialsManager.experiences.map { Credential.experience($0) } +
        credentialsManager.competitions.map { Credential.competition($0) } +
        credentialsManager.projects.map { Credential.project($0) }
        credentials.sort(by: { $0.dateAdded > $1.dateAdded })
        return credentials
    }
    
    var sortedCredentials: [Credential] {
        switch sortSelection {
        case .noSort:
            return credentials
        case .category:
            return credentials.sorted { $0.type.rawValue < $1.type.rawValue }
        case .importance:
            return credentials.sorted { $0.importance > $1.importance }
        }
    }
    
    var experiences: [Experience] {
        switch sortSelection {
        case .noSort, .category:
            return credentialsManager.experiences
        case .importance:
            return credentialsManager.experiences.sorted { $0.importance > $1.importance }
        }
    }
    
    var competitions: [Competition] {
        switch sortSelection {
        case .noSort, .category:
            return credentialsManager.competitions
        case .importance:
            return credentialsManager.competitions.sorted { $0.importance > $1.importance }
        }
    }
    
    var achievementsAndHonours: [AchievementAndHonour] {
        switch sortSelection {
        case .noSort, .category:
            return credentialsManager.achievementAndHonours
        case .importance:
            return credentialsManager.achievementAndHonours.sorted { $0.importance > $1.importance }
        }
    }
    
    var projects: [Project] {
        switch sortSelection {
        case .noSort, .category:
            return credentialsManager.projects
        case .importance:
            return credentialsManager.projects.sorted { $0.importance > $1.importance }
        }
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

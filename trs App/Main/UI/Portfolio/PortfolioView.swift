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
    
    var body: some View {
        NavigationStack {
            list
                .safeAreaInset(edge: .top) {
                    FilterButtons()
                }
                .navigationTitle("My Portfolio")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
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
                }
        }
        .sheet(isPresented: $showingAddCredentialView) {
            CategoriesView()
        }
        .sheet(isPresented: $showingTipsView) {
            TipsView(currentSelection: filterManager.currentSelection)
        }
    }
    
    var list: some View {
        List {
            switch filterManager.currentSelection {
            case .all:
                EmptyView()
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
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

//
//  FilterButtons.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct FilterButtons: View {
    
    @ObservedObject var filterManager: FilterManager = .shared
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                filterButton(text: "All",
                             isSelected: filterManager.currentSelection == FilterType.all,
                             updateTo: .all)
                
                filterButton(text: "Experiences",
                             isSelected: filterManager.currentSelection == FilterType.experiences,
                             updateTo: .experiences)
                
                filterButton(text: "Competitions",
                             isSelected: filterManager.currentSelection == FilterType.competitions,
                             updateTo: .competitions)
                
                filterButton(text: "Achievements/Honours",
                             isSelected: filterManager.currentSelection == FilterType.achievementsAndHonours,
                             updateTo: .achievementsAndHonours)
                
                filterButton(text: "Projects",
                             isSelected: filterManager.currentSelection == FilterType.projects,
                             updateTo: .projects)
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    @ViewBuilder
    func filterButton(text: String, isSelected: Bool, updateTo: FilterType) -> some View {
        Button {
            filterManager.updateCurrentSelection(to: updateTo)
        } label: {
            Text(text)
                .padding(10)
                .frame(minWidth: 50)
                .background(isSelected ? Color.accentColor : Color.accentColor.opacity(0.5))
                .foregroundColor(.white)
                .controlSize(.mini)
                .fontWeight(.semibold)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct FilterButtons_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtons()
    }
}

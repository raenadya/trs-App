//
//  FilterButtons.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct FilterButtons: View {
    
    
    @Binding var allCount: Int
    @Binding var experienceCount: Int
    @Binding var competitionsCount: Int
    @Binding var achievementsAndHonoursCount: Int
    @Binding var projectsCount: Int
    
    @ObservedObject var filterManager: FilterManager = .shared
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                filterButton(text: "All (\(allCount))",
                             isSelected: filterManager.currentSelection == CategoryType.all,
                             updateTo: .all)
                
                filterButton(text: "Experiences (\(experienceCount))",
                             isSelected: filterManager.currentSelection == CategoryType.experiences,
                             updateTo: .experiences)
                
                filterButton(text: "Competitions (\(competitionsCount))",
                             isSelected: filterManager.currentSelection == CategoryType.competitions,
                             updateTo: .competitions)
                
                filterButton(text: "Achievements/Honours (\(achievementsAndHonoursCount))",
                             isSelected: filterManager.currentSelection == CategoryType.achievementsAndHonours,
                             updateTo: .achievementsAndHonours)
                
                filterButton(text: "Projects (\(projectsCount))",
                             isSelected: filterManager.currentSelection == CategoryType.projects,
                             updateTo: .projects)
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    @ViewBuilder
    func filterButton(text: String, isSelected: Bool, updateTo: CategoryType) -> some View {
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

//struct FilterButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterButtons()
//    }
//}

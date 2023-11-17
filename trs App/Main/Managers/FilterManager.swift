//
//  FilterManager.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

enum CategoryType {
    case all, experiences, competitions, achievementsAndHonours, projects
}

class FilterManager: ObservableObject {
    static let shared: FilterManager = .init()
    
    @Published var currentSelection: CategoryType = .all
    
    func updateCurrentSelection(to newValue: CategoryType) {
        withAnimation {
            currentSelection = newValue
        }
    }
}

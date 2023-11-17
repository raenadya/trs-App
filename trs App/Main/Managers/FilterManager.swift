//
//  FilterManager.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import Foundation

enum FilterType {
    case all, experiences, competitions, achievementsAndHonours, projects
}

class FilterManager: ObservableObject {
    static let shared: FilterManager = .init()
    
    @Published var currentSelection: FilterType = .all
    
    func updateCurrentSelection(to newValue: FilterType) {
        currentSelection = newValue
    }
}

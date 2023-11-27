//
//  CoinsManager.swift
//  trs App
//
//  Created by Kierae NJ on 23/11/23.
//

import SwiftUI

class CoinsManager: ObservableObject {
    static let shared: CoinsManager = .init()

    @Published var coins = 0
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    @AppStorage("coins", store: .standard) private var internalCoins = 0
    
    init() {
        updatePublishedVariables()
    }
    
    func updatePublishedVariables() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.coins = self.internalCoins
        }
    }

    func addCoins(amount: Int) {
        internalCoins += amount
        updatePublishedVariables()
        showAlert(title: "Credential added", message: "^[\(amount) Song](inflect: true) added!")
    }

    func removeCounts(amount: Int) {
        internalCoins -= amount
        updatePublishedVariables()
        showAlert(title: "Credential removed", message: "^[\(amount) Song](inflect: true) removed.")
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

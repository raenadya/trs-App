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
    @Published var alertMessage = ""
    
    @AppStorage("coins", store: .standard) private var internalCoins = 0
    
    init() {
        
    }
    
    func updatePublishedCoins() {
        self.coins = internalCoins
    }

    func addCoins(amount: Int) {
        internalCoins += amount
        updatePublishedCoins()
        showAlert(message: "\(amount) coins added!")
    }

    func removeCounts(amount: Int) {
        internalCoins -= amount
        updatePublishedCoins()
        showAlert(message: "\(amount) coins removed!")
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

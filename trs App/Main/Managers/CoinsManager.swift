//
//  CoinsManager.swift
//  trs App
//
//  Created by Kierae NJ on 23/11/23.
//

import SwiftUI

class CoinsManager: ObservableObject {
    static let shared: CoinsManager = .init()

    @Published var coinCount = 0
    @Published var showAlert = false
    @Published var alertMessage = ""


    // Function to add coins
    func addCoins(amount: Int) {
        coinCount += amount
        showAlert(message: "You earned \(amount) coins.")
    }

    // Function to remove coins
    func removeCoins(amount: Int) {
        if coinCount >= amount {
            coinCount -= amount
            showAlert(message: "You lost \(amount) coins.")
        } else {
            showAlert(message: "Insufficient coins to perform this action.")
        }
    }

    // Function to show an alert with a custom message
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

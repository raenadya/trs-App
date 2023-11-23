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

    func addCredential(amount: Int) {
        coinCount += amount
        showAlert(message: "\(amount) coins added!")
    }

    func removeCredential(amount: Int) {
        coinCount -= amount
        showAlert(message: "\(amount) coins removed!")
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

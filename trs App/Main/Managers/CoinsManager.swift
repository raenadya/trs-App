//
//  CoinsManager.swift
//  trs App
//
//  Created by Kierae NJ on 23/11/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class CoinsManager: ObservableObject {
    static let shared: CoinsManager = .init()

    @Published var coins = 0
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    @AppStorage("coins", store: .standard) private var internalCoins = 0
    
    init() {
        addListener()
    }
    
    func addListener() {
        if let uid = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.internalCoins = data["coins"] as? Int ?? 0
                self.updatePublishedVariables()
            }
        }
    }
    
    func updatePublishedVariables() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.coins = self.internalCoins
        }
    }

    func addCoins(amount: Int) {
        if let uid = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("users").document(uid).setData([
                "coins": self.coins + 5
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.updatePublishedVariables()
                }
            }
        }
        showAlert(title: "Credential added", message: "^[\(amount) Song](inflect: true) added!")
    }

    func removeCounts(amount: Int) {
        if let uid = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("users").document(uid).setData([
                "coins": self.coins - 5
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.updatePublishedVariables()
                }
            }
        }
        showAlert(title: "Credential removed", message: "^[\(amount) Song](inflect: true) removed.")
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

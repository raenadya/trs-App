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
    @Published var alertMessage: LocalizedStringKey = ""
    
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
        if let uid = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email {
            Firestore.firestore().collection("users").document(uid).setData([
                "email": email,
                "coins": self.coins + amount
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.updatePublishedVariables()
                }
            }
        }
        self.showAlert(title: "Credential added", message: LocalizedStringKey("^[\(amount) coins](inflect: true) added!"))
    }

    func removeCoins(amount: Int, showsAlert: Bool = true) {
        if let uid = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email {
            Firestore.firestore().collection("users").document(uid).setData([
                "email": email,
                "coins": self.coins - amount
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.updatePublishedVariables()
                }
            }
        }
        if showsAlert {
            self.showAlert(title: "Credential removed", message: LocalizedStringKey("^[\(amount) coins](inflect: true) removed."))
        }
    }

    private func showAlert(title: String, message: LocalizedStringKey) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

//
//  AuthenticationManager.swift
//  trs App
//
//  Created by Tristan Chay on 20/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthenticationManager: ObservableObject {
    static let shared: AuthenticationManager = .init()
    
    @Published var isLoggedIn: Bool = false
    @Published var email: String?
    
    init() {
        verifyAuthenticationState()
        updatePublishedVariables()
    }
    
    private func verifyAuthenticationState() {
        if Auth.auth().currentUser != nil {
            withAnimation {
                self.isLoggedIn = true
            }
        } else {
            withAnimation {
                self.isLoggedIn = false
            }
        }
    }
    
    private func updatePublishedVariables() {
        email = Auth.auth().currentUser?.email
    }
    
    func signIn(email: String, password: String, _ completion: @escaping ((Result<Bool, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                completion(.failure(err))
            } else {
                withAnimation {
                    self.isLoggedIn = true
                }
                self.updatePublishedVariables()
                completion(.success(true))
            }
        }
    }
    
    func signOut(_ completion: @escaping ((Result<Bool, Error>) -> Void)) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print("Error signing out: ", signOutError)
            completion(.failure(signOutError))
        }
        
        updatePublishedVariables()
        verifyAuthenticationState()
    }
    
    func forgotPassword(
        email: String,
        _ completion: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func createAccount(
        email: String,
        password: String,
        _ completion: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                completion(.failure(err))
            } else {
                if let currentUserUID = Auth.auth().currentUser?.uid {
                    Firestore.firestore().collection("users").document(currentUserUID).setData([
                        "email": email,
                        "coins": 0
                    ]) { err in
                        if let err = err {
                            completion(.failure(err))
                        } else {
                            completion(.success(true))
                        }
                    }
                }
                self.updatePublishedVariables()
                self.verifyAuthenticationState()
            }
        }
    }
    
    func updatePassword(
        from oldPassword: String,
        to newPassword: String,
        _ completion: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        let credential = EmailAuthProvider.credential(withEmail: Auth.auth().currentUser?.email ?? "", password: oldPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    public enum DeleteAccountError: Error {
        case wrongPasswordToReauth
        case failedToDeleteFromFirestore
        case failedToDeleteAccount
        case failedToSignOut
        
        var localizedDescription: String {
            switch self {
            case .wrongPasswordToReauth:
                return NSLocalizedString("The password you have entered to delete your account is incorrect.", comment: "Wrong password")
            case .failedToDeleteFromFirestore:
                return NSLocalizedString("An error has occurred while attempting to delete your account.", comment: "Firestore error")
            case .failedToDeleteAccount:
                return NSLocalizedString("An error has occurred while attempting to delete your account.", comment: "Account error")
            case .failedToSignOut:
                return NSLocalizedString("An error has occurred while attempting to sign out of deleted account. Please sign out manually.", comment: "Sign out error")
            }
        }
    }
    
    func deleteAccount(password: String, _ completion: @escaping ((Result<Bool, DeleteAccountError>) -> Void)) {
        let credential = EmailAuthProvider.credential(withEmail: Auth.auth().currentUser?.email ?? "", password: password)
        Auth.auth().currentUser?.reauthenticate(with: credential) { result, error in
            if let error = error {
                completion(.failure(DeleteAccountError.wrongPasswordToReauth))
            } else {
                if let uid = Auth.auth().currentUser?.uid {
                    Firestore.firestore().collection("users").document(uid).delete() { err in
                        if let err = err {
                            completion(.failure(DeleteAccountError.failedToDeleteFromFirestore))
                        } else {
                            let user = Auth.auth().currentUser
                            user?.delete { error in
                                if let error = error {
                                    completion(.failure(DeleteAccountError.failedToDeleteAccount))
                                } else {
                                    self.signOut { result in
                                        switch result {
                                        case .success(_):
                                            break
                                        case .failure(let failure):
                                            completion(.failure(DeleteAccountError.failedToSignOut))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

//
//  SignUpView.swift
//  trs App
//
//  Created by Tristan Chay on 20/11/23.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var signInView: Bool
    
    @State var isLoading = false
    
    @State var email = ""
    @State var password = ""
    @State var showingPassword = false
    
    @State var alertHeader = ""
    @State var alertMessage = ""
    @State var showingAlert = false
    
    @ObservedObject var authManager: AuthenticationManager = .shared
    
    @FocusState var passwordFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Join [APP NAME]!")
                .fontWeight(.black)
                .font(.system(size: 35))
                .padding(.horizontal)
            
            VStack {
                infoFields
                signUpButton
                bottomText
            }
            .padding(.horizontal)
        }
        .alert(alertHeader, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    var infoFields: some View {
        VStack(spacing: 10) {
            TextField("Email Address", text: $email)
                .padding()
                .background(.ultraThickMaterial)
                .cornerRadius(16)
                .keyboardType(.emailAddress)
                .textContentType(.username)
            
            passwordField
        }
    }
    
    var passwordField: some View {
        ZStack(alignment: .trailing) {
            if showingPassword {
                TextField("Password", text: $password)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(16)
                    .textContentType(.password)
                    .focused($passwordFieldFocused)
            } else {
                SecureField("Password", text: $password)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(16)
                    .textContentType(.password)
                    .focused($passwordFieldFocused)
            }
            Button {
                showingPassword.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    passwordFieldFocused = true
                }
            } label: {
                Image(systemName: showingPassword ? "eye.slash" : "eye")
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 20)
        }
    }
    
    var signUpButton: some View {
        Button {
            if !email.isEmpty && !password.isEmpty {
                isLoading = true
                authManager.createAccount(email: email, password: password) { result in
                    switch result {
                    case .success(_):
                        isLoading = false
                    case .failure(let failure):
                        isLoading = false
                        alertHeader = "Error"
                        alertMessage = "\(failure.localizedDescription)"
                        showingAlert = true
                    }
                }
            }
        } label: {
            Text("Sign Up")
                .padding()
                .frame(maxWidth: 300)
                .foregroundColor(isLoading ? .clear : .white)
                .fontWeight(.semibold)
                .background(Color.accentColor)
                .cornerRadius(16)
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
        .buttonStyle(.plain)
        .disabled(email.isEmpty || password.isEmpty || isLoading)
        .padding(.vertical
        
        )
    }
    
    var bottomText: some View {
        HStack {
            Text("Already have an account?")
                .minimumScaleFactor(0.1)
            Button {
                withAnimation {
                    signInView.toggle()
                }
            } label: {
                Text("Log In")
                    .foregroundColor(Color.accentColor)
                    .underline()
                    .fontWeight(.semibold)
            }
            .minimumScaleFactor(0.1)
            .buttonStyle(.plain)
        }
        .font(.subheadline)
        .padding(.top, 5)
    }
}

#Preview {
    SignUpView(signInView: .constant(false))
}

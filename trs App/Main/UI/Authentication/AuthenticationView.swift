//
//  AuthenticationView.swift
//  trs App
//
//  Created by Tristan Chay on 20/11/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @AppStorage("signInView", store: .standard) var signInView = true
    
    var body: some View {
        VStack {
            if signInView {
                SignInView(signInView: $signInView)
            } else {
                SignUpView(signInView: $signInView)
            }
        }
        .animation(.default, value: signInView)
    }
}

#Preview {
    AuthenticationView()
}

//
//  CredentialInformationView.swift
//  trs App
//
//  Created by Tristan Chay on 18/11/23.
//

import SwiftUI

struct CredentialInformationView: View {
    
    @State var credential: Credential
    
    var body: some View {
        List {
            Section {
                Text(credential.title)
                Text(credential.organiserName)
            }
            
            if let description = credential.description {
                Text(description)
            }
        }
    }
}

//struct CredentialInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CredentialInformationView()
//    }
//}

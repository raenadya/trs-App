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
            Section("Organiser") {
                Text(credential.organiserName)
            }
            Section("Date") {
                Text(credential.startDate, style: .date)
                Text(credential.endDate, style: .date)
            }
            Section("Description") {
                Text(credential.description!)
            }
            Section("Documents") {
                // document
            }
            Section("Tag") {
                // Text($credential.competitionTagSelection)
                // Text($credential.experienceTagSelection)
            }
        }
        .navigationTitle(credential.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    EditCredentialView
//                } label: {
//                    Text("Edit")
//                }
//            }
        }
    }
}


//struct CredentialInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CredentialInformationView()
//    }
//}


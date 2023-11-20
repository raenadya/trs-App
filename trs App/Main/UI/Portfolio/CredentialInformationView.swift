//
//  CredentialInformationView.swift
//  trs App
//
//  Created by Tristan Chay on 18/11/23.
//

import SwiftUI

struct CredentialInformationView: View {
    
    @State var credential: Credential
    @State private var isEditing = false
    
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
                switch credential {
                case .experience(let experience):
                    Text(experience.tag.rawValue)
                    
                case .competition(let competition):
                    Text(competition.tag.rawValue)
                    
                case .achievementAndHonour(let achievementAndHonour):
                    Text("")
                    
                case .project(let project):
                    Text("")
                }
            }
            
            
            
        }
        .navigationTitle(credential.title)
        .toolbar {
            EditButton(placement: .navigationBarTrailing) {
                if isEditing = true {
                    NavigationLink(destination: EditCredentialView);, isActive: $isEditing)
                }
            }
        }
    }
}


    //struct CredentialInformationView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        CredentialInformationView()
    //    }
    //}

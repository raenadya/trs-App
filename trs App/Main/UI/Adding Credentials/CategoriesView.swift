//
//  CategoriesView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct CategoriesView: View {
    
    @Binding var showingAddCredentialView: Bool
    
    @State var titleToBePassed = ""
    @State var typeToBePassed: CategoryType = .all
    @State var showingCredentialInformation = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                credential(text: "Experiences", systemImage: "shared.with.you", forType: .experiences)
                credential(text: "Competitions", systemImage: "figure.open.water.swim", forType: .competitions)
                credential(text: "Achievements/Honours", systemImage: "trophy.fill", forType: .achievementsAndHonours)
                credential(text: "Projects", systemImage: "text.badge.checkmark", forType: .projects)
            }
            .navigationTitle("Categories")
            .navigationDestination(isPresented: $showingCredentialInformation) {
                CredentialInformationView(showingAddCredentialView: $showingAddCredentialView,
                                          showingCredentialInformation: $showingCredentialInformation,
                                          navigationTitle: $titleToBePassed,
                                          forType: $typeToBePassed)
            }
        }
    }
    
    @ViewBuilder
    func credential(text: String, systemImage: String, forType type: CategoryType) -> some View {
        Button {
            typeToBePassed = type
            titleToBePassed = text
            showingCredentialInformation.toggle()
        } label: {
            HStack(spacing: 5) {
                Label(text, systemImage: systemImage)
                    .font(.title3)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 2.5/3, height: 60)
            .foregroundColor(.white)
            .background(Color.accentColor.opacity(0.7))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

//struct CategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesView()
//    }
//}

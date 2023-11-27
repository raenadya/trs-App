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
            GeometryReader { geometry in
                VStack(spacing: 15) {
                    Spacer()
                    credential(geometry: geometry, systemImage: "shared.with.you", forType: .experiences)
                    credential(geometry: geometry, systemImage: "figure.open.water.swim", forType: .competitions)
                    credential(geometry: geometry, systemImage: "trophy.fill", forType: .achievementsAndHonours)
                    credential(geometry: geometry, systemImage: "text.badge.checkmark", forType: .projects)
                    Spacer()
                }
                .navigationTitle("Categories")
                .navigationDestination(isPresented: $showingCredentialInformation) {
                    NewCredentialsView(showingAddCredentialView: $showingAddCredentialView,
                                       showingCredentialInformation: $showingCredentialInformation,
                                       navigationTitle: $titleToBePassed,
                                       forType: $typeToBePassed)
                }
            }
        }
    }
    
    @ViewBuilder
    func credential(geometry: GeometryProxy, systemImage: String, forType type: CategoryType) -> some View {
        HStack {
            Spacer()
            Button {
                typeToBePassed = type
                titleToBePassed = type.rawValue
                showingCredentialInformation.toggle()
            } label: {
                HStack(spacing: 5) {
                    Label(type.rawValue, systemImage: systemImage)
                        .font(.title3)
                }
                .padding()
                .frame(width: geometry.size.width * 2.5/3, height: 60)
                .foregroundColor(.white)
                .background(Color.accentColor.opacity(0.7))
                .cornerRadius(16)
            }
            .buttonStyle(.plain)
            Spacer()
        }
    }
}

//struct CategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesView()
//    }
//}

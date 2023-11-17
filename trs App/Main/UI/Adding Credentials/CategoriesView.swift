//
//  CategoriesView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                credential(text: "Experiences", systemImage: "shared.with.you")
                credential(text: "Competitions", systemImage: "figure.open.water.swim")
                credential(text: "Achievements/Honours", systemImage: "trophy.fill")
                credential(text: "Projects", systemImage: "text.badge.checkmark")
            }
            .navigationTitle("Categories")
        }
    }
    
    @ViewBuilder
    func credential(text: String, systemImage: String) -> some View {
        NavigationLink {
            
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
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

//
//  PortfolioView.swift
//  trs App
//
//  Created by Tristan Chay on 16/11/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @State var showingAddCredentialView = false
    
    var body: some View {
        NavigationStack {
            List {
                Text("PortfolioView")
            }
            .safeAreaInset(edge: .top) {
                FilterButtons()
            }
            .navigationTitle("My Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddCredentialView.toggle()
                    } label: {
                        Label("Add credential", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddCredentialView) {
            CategoriesView()
        }
    }
}


struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

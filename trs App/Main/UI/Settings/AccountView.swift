//
//  AccountView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/20.
//

import SwiftUI



struct AccountView: View {
    
    @State private var textEntered = ""
    
    var body: some View {
        NavigationStack{
            List {
                Section("Me") {
                    TextField("What is your Name?", text: $textEntered)
                    Text(textEntered == "" ? "" : "Hello, \(textEntered)!")
                }
                Section("Mail Information"){
                    
                }
            }
            .navigationTitle("Account")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

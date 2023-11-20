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
            
            List{
                TextField("What is your name?", text: $textEntered)
                    .textFieldStyle(.roundedBorder)
                
                Text(textEntered == "" ? "" : "Hello, \(textEntered)!")
            }
            
            .navigationTitle("Account")
            .toolbar{
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

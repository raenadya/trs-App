//
//  CoinSystemView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/22.
//

import SwiftUI

struct CoinSystemView: View {
    
    @State private var showCoinAlert = false
    @State private var showDeleteAlert = false
    @State private var coinNumber = 0
    
    var body: some View {
        VStack{
            NavigationStack {
                
                Button("after credential added") {
                    showCoinAlert = true
                    coinNumber += 5
                }
                .alert(isPresented: $showCoinAlert) {
                    Alert(
                        title: Text("Congrats!"),
                        message: Text("You've earned 5 coins."),
                        dismissButton: .default(Text("OK"))
                    )
                    
                }
                
                Button("after credential delete"){
                    showDeleteAlert = true
                    coinNumber -= 5
                }
                .alert(isPresented: $showDeleteAlert){
                    Alert(
                    title: Text("Delete"),
                    message: Text("You lose 5 coins"),
                    dismissButton:
                            .default(Text("OK"))
                    )
                }
                
            Text("\(coinNumber) coins")
                .padding()
                }
            }
        }
        
        struct CoinSystemView_Previews: PreviewProvider {
            static var previews: some View {
                CoinSystemView()
            }
        }
    }


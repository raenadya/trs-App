//
//  CoinSystemView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/22.
//

import SwiftUI

struct CoinSystemView: View {
    
    @State private var showCoinAlert = false
    @State private var coinNumber = 0
    
    var body: some View {
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
            }
        }
        
        struct CoinSystemView_Previews: PreviewProvider {
            static var previews: some View {
                CoinSystemView()
            }
        }
    }


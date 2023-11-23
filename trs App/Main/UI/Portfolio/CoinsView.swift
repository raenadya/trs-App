//
//  CoinsView.swift
//  trs App
//
//  Created by Kierae NJ on 23/11/23.
//

import SwiftUI

struct CoinsView: View {
    @ObservedObject var coinsManager: CoinsManager = CoinsManager.shared

    var body: some View {
        HStack {
            Spacer()
            Text("Coins: \(coinsManager.coinCount)")
                .padding()
                .foregroundColor(.black)
        }
    }
}

struct CoinsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsView()
    }
}

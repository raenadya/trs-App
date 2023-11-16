//
//  FilterButtons.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct FilterButtons: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All") { }
                Button("Experiences") { }
                Button("Competitions") { }
                Button("Achievements/Honours") { }
                Button("Projects") { }
                Spacer()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(.mini)
            .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct FilterButtons_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtons()
    }
}

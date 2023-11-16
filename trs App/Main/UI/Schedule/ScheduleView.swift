//
//  ScheduleView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Schedule View")
            }
            .navigationTitle("Schedule")
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

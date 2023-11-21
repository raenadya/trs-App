//
//  NotificationView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/20.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var NotificationBeforeCompetition = true
    @State private var NotificationAfterCompeition = true

    
    var body: some View {
        
        NavigationStack{
        
            List{
                
                Section(""){
                    Toggle("Notification Before Competition", isOn: $NotificationBeforeCompetition)
                    
                    Toggle("Notification After Competition", isOn: $NotificationAfterCompeition)
                }
                
            }
            
            
            .navigationTitle("Notification")
            
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

//
//  ScheduleView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct ScheduleView: View {
    
    
    @State private var addSheet = false
    
    var body: some View {
        NavigationStack{
            List {
                Section("Schedule your upcoming activities/compeitions here!")
                {
                    //code
                }
            }
            .navigationTitle("Schedule")
            .toolbar{
                ToolbarItemGroup{
                    Button{
                        addSheet = true
                    }label:{
                        Image(systemName:"plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
                
            }
        .sheet(isPresented: $addSheet){
            AddSheetView()
        }
        }
    }
    
    


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

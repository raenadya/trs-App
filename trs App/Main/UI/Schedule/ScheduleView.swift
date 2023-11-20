//
//  ScheduleView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct ScheduleView: View {
    
    
    @State private var addSheet = false
    @State private var scheduledItems = ["Schedule your upcoming activities here!"]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(scheduledItems, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteItems)
                Text("")
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
            }
        }
        .sheet(isPresented: $addSheet){
            AddSheetView()
        }
    }
    
    func deleteItems (at offsets: IndexSet) {
        scheduledItems.remove(atOffsets:offsets)
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

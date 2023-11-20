//
//  AddSheetView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/18.
//

import SwiftUI

struct AddSheetView: View {
    
    @State private var activityName = ""
    @State private var organiserName = ""
    @State private var description = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var startDate = Date()
    @State var endDate = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(""){
                        TextField("Activity Name", text:$activityName)
                        TextField("Organiser Name", text: $organiserName)
                    }
                        
                    Section("") {
                        DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                            Text("Start Date")
                        }
                        
                        DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                            Text("End Date")
                        }
                    }
                    
                    Section(""){
                        TextField("Description", text: $description)
                        }
                    }
                Text("All The Best!")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                }
            }
        }
    }


struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView()
    }
}

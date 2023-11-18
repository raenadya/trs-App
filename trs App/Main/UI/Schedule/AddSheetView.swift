//
//  AddSheetView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/18.
//

import SwiftUI

struct AddSheetView: View {
    
    @State private var textEntered = ""
    @State private var start = Date()
    @State private var end = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section(""){
                        TextField("Competition Name", text:$textEntered)
                        TextField("Organiser Name", text: $textEntered)
                    }
                        
                    Section("") {
                        DatePicker(selection: $start, in: ...Date(), displayedComponents: .date) {
                            Text("Start Date")
                        }
                        
                        DatePicker(selection: $start, in: ...Date(), displayedComponents: .date) {
                            Text("End Date")
                        }
                    }
                    
                    Section(""){
                        TextField("Description", text: $textEntered)
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

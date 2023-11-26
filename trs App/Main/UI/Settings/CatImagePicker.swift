//
//  CatImagePicker.swift
//  trs App
//
//  Created by Tristan Chay on 26/11/23.
//

import SwiftUI

struct CatImagePicker: View {
    
    @State private var images = (1...30).map { "cat\($0)" }
    
    @ObservedObject var avatarManager: AvatarManager = .shared
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                    ForEach(images, id: \.self) { imageName in
                        Button {
                            withAnimation {
                                avatarManager.updateAvatarImage(to: imageName)
                            }
                            dismiss.callAsFunction()
                        } label: {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(avatarManager.avatarImageName == imageName ? RoundedRectangle(cornerRadius: 1000) : RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Choose your cat!")
        }
    }
}

//struct CatImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CatImagePicker()
//    }
//}

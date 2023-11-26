//
//  AvatarView.swift
//  trs App
//
//  Created by Tristan Chay on 26/11/23.
//

import SwiftUI

struct AvatarView: View {
    
    @State private var isImagePickerPresented = false
    
    @ObservedObject var coinsManager: CoinsManager = .shared
    @ObservedObject var avatarManager: AvatarManager = .shared
    
    var body: some View {
        ScrollView {
            cat
            accessories
        }
        .navigationTitle("Avatar")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isImagePickerPresented) {
            CatImagePicker()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("\(coinsManager.coins) coins")
                    .fontWeight(.bold)
                    .underline()
                    .foregroundColor(Color.accentColor)
            }
        }
    }
    
    var cat: some View {
        VStack {
            if let avatarImageName = avatarManager.avatarImageName {
                Menu {
                    Button {
                        isImagePickerPresented.toggle()
                    } label: {
                        Label("Choose a new cat", systemImage: "photo.stack")
                    }
                    Divider()
                    Button(role: .destructive) {
                        avatarManager.updateAvatarImage(to: nil)
                    } label: {
                        Label("Remove cat", systemImage: "trash")
                    }
                } label: {
                    Image(avatarImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
            } else {
                Button {
                    isImagePickerPresented.toggle()
                } label: {
                    Text("Choose your cat!")
                        .padding()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical)
    }
    
    var accessories: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: 3), spacing: 15) {
            ForEach(AvatarItem.allCases, id: \.id) { item in
                Image(item.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
        }
        .padding()
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

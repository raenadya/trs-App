//
//  AvatarView.swift
//  trs App
//
//  Created by Tristan Chay on 26/11/23.
//

import SwiftUI

struct AvatarView: View {
    
    @State var selectedAccessory: AvatarItem = .bowTie
    
    @State var showingAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
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
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Buy", role: .none) {
                if coinsManager.coins - selectedAccessory.cost >= 0 {
                    coinsManager.removeCoins(amount: selectedAccessory.cost, showsAlert: false)
                    avatarManager.addOwnedAccessory(withID: selectedAccessory.id)
                }
            }
        } message: {
            Text(alertMessage)
        }
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
        .padding(.top, 100)
    }
    
    var accessories: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: 3), spacing: 15) {
            ForEach(AvatarItem.allCases, id: \.id) { item in
                Button {
                    if !avatarManager.ownedAccessories.contains(item.id) {
                        selectedAccessory = item
                        alertTitle = "Purchase"
                        alertMessage = "Would you like to buy this accessory \"\(item.rawValue.split(separator: " ").dropLast().joined(separator: " "))\" for \(item.cost)c."
                        showingAlert = true
                    }
                } label: {
                    Image(item.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .opacity(avatarManager.ownedAccessories.contains(item.id) ? 1 : 0.5)
                }
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

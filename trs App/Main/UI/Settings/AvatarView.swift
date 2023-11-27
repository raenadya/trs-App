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
        VStack {
            cat
            ScrollView(.vertical, showsIndicators: false) {
                accessories
            }
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
                .overlay {
                    if let selectedAccessoryID = avatarManager.selectedAccessoryID {
                        Image(avatarManager.getImageName(withID: selectedAccessoryID))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .scaleEffect(avatarManager.scale)
                            .rotationEffect(Angle.degrees(avatarManager.rotation))
                            .position(avatarManager.location)
                            .gesture(
                                simpleDrag
                            )
                    }
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
        .padding(.vertical, 60)
    }
    
    @GestureState private var startLocation: CGPoint? = nil
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? avatarManager.location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                if newLocation.y >= 240 {
                    if newLocation.x >= 274 {
                        avatarManager.updateLocation(to: CGPoint(x: 274, y: 240))
                    } else if newLocation.x <= -73 {
                        avatarManager.updateLocation(to: CGPoint(x: -73, y: 240))
                    } else {
                        avatarManager.updateLocation(to: CGPoint(x: newLocation.x, y: 240))
                    }
                } else if newLocation.y <= -45 {
                    if newLocation.x >= 274 {
                        avatarManager.updateLocation(to: CGPoint(x: 274, y: -45))
                    } else if newLocation.x <= -73 {
                        avatarManager.updateLocation(to: CGPoint(x: -73, y: -45))
                    } else {
                        avatarManager.updateLocation(to: CGPoint(x: newLocation.x, y: -45))
                    }
                } else {
                    if newLocation.x >= 274 {
                        avatarManager.updateLocation(to: CGPoint(x: 274, y: newLocation.y))
                    } else if newLocation.x <= -73 {
                        avatarManager.updateLocation(to: CGPoint(x: -73, y: newLocation.y))
                    } else {
                        avatarManager.updateLocation(to: newLocation)
                    }
                }
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? avatarManager.location
            }
            .simultaneously(with: RotationGesture()
                .onChanged { value in
                    avatarManager.updateDegrees(to: value.degrees)
                }
            )
            .simultaneously(with: MagnificationGesture()
                .onChanged { value in
                    if value.magnitude > 3 {
                        avatarManager.updateScale(to: 3)
                    } else if value.magnitude < 0.5 {
                        avatarManager.updateScale(to: 0.5)
                    } else {
                        avatarManager.updateScale(to: value.magnitude)
                    }
                }
            )
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
                    } else {
                        avatarManager.selectAccessory(withID: item.id)
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

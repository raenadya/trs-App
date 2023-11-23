import SwiftUI

struct AvatarView: View {
    
    @State var showingAvatarView = false
    @State private var showingImagePicker = false
    @State private var avatarImage: Image = Image("bow tie (10c)")
    @State private var profileImage: UIImage? = nil
    @State private var showBuyAlert = false
    @State private var hasClickedOK = false
    
    @State private var clickedStatus: [Bool] = Array(repeating: false, count: 21)
    
    var body: some View {
        
        VStack {
            ZStack {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .onTapGesture {
                        showingImagePicker.toggle()
                    }

                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }
            }
        }
        .scaledToFit()
        .frame(height: 600)
        .frame(width: 400)

            
            HStack (spacing: 70) {
                
                VStack{
                    
                    // cancel button
                    
                    Button {
                        self.avatarImage = Image("")
                    } label: {
                        Image("no avatar")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    // party hat (10c)
                    
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("party hat (10c)")
                        }
                    } label: {
                        Image("party hat (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 10 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // graduation hat (20c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("graduation hat (20c)")
                        }
                    } label: {
                        Image("graduation hat (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 20 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // cat ears (30c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("cat ears (30c)")
                        }
                    } label: {
                        Image("cat ears (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 30 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // headphones (40c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("headphones (40c)")
                        }
                    } label: {
                        Image("headphones (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 40 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // santa hat (50c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("santa hat (50c)")
                        }
                    } label: {
                        Image("santa hat (50c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 50 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                }
                VStack{
                    // cap (10c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("cap (10c)")
                        }
                    } label: {
                        Image("cap (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 10 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // chef (20c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("chef (20c)")
                        }
                    } label: {
                        Image("chef (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 20 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // viking helmet (20c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("viking helmet (20c)")
                        }
                    } label: {
                        Image("viking helmet (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 20 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // devil horns (30c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("devil horns (30c)")
                        }
                    } label: {
                        Image("devil horns (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 30 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // mexican hat (40c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("mexican hat (40c)")
                        }
                    } label: {
                        Image("mexican hat (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 40 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // tiara (50c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("tiara (50c)")
                        }
                    } label: {
                        Image("tiara (50c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 50 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                }
                VStack{
                    // flower crown (10c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("flower crown (10c)")
                        }
                    } label: {
                        Image("flower crown (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 10 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // crown (20c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("crown (20c)")
                        }
                    } label: {
                        Image("crown (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 20 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // witch hat (20c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("witch hat (20c)")
                        }
                    } label: {
                        Image("witch hat (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 20 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // angel halo (30c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("angel halo (30c)")
                        }
                    } label: {
                        Image("angel halo (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 10 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // top hat (40c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("top hat (40c)")
                        }
                    } label: {
                        Image("top hat (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 40 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                    // plant (30c)
                    
                    Button {
                        if !hasClickedOK {
                            showBuyAlert = true
                        } else {
                            self.avatarImage = Image("plant (30c)")
                        }
                    } label: {
                        Image("plant (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    .alert(isPresented: $showBuyAlert) {
                        Alert(
                            title: Text("Do you want to buy this accessory?"),
                            message: Text("This accessory costs 10 coins."),
                            primaryButton: .default(Text("OK")) {
                                hasClickedOK = true
                            },
                            secondaryButton: .cancel {
                                showBuyAlert = false
                            }
                        )
                    }
                    
                }
            }
        }
        
    }

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

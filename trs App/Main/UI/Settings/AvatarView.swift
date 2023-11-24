import SwiftUI

struct AvatarView: View {
    
    @State var showingAvatarView = false
    @State var avatarImage: Image = Image("defaultAvatar")
    @State private var profileImage: UIImage? = nil
    @State private var coins: Int = 100
    @State private var isImagePickerPresented: Bool = false
    
    @State private var activeAlert: AlertType?
    
    enum AlertType: Identifiable {
        case noAvatar, bowTie, cap, catEars, chef, crown, devilHorns, flowerCrown, graduationHat, headphones, mexicanHat, partyHat, plant, rabbitEars, santaHat, tiara, topHat, vikingHelmet, witchHat, profilePhoto
        
        var id: Int {
            switch self {
            case .noAvatar: return 0
            case .bowTie: return 1
            case .cap: return 2
            case .catEars: return 3
            case .chef: return 4
            case .crown: return 5
            case .devilHorns: return 6
            case .flowerCrown: return 7
            case .graduationHat: return 8
            case .headphones: return 9
            case .mexicanHat: return 10
            case .partyHat: return 11
            case .plant: return 12
            case .rabbitEars: return 13
            case .santaHat: return 14
            case .tiara: return 15
            case .topHat: return 16
            case .vikingHelmet: return 17
            case .witchHat: return 18
            case .profilePhoto: return 19
            }
        }
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .position(x: 130, y: 70)
                
                if let profileImage = profileImage {
                    Image (uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .foregroundColor(.purple)
                        .scaledToFit()
                        .fontWeight(.light)
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            activeAlert = .noAvatar
                        }
                }
            }
            
            
            HStack(spacing: 40) {
                VStack {
                    Button {
                        activeAlert = .noAvatar
                    } label: {
                        Image("no avatar")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .bowTie
                    } label: {
                        Image("bow tie (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .cap
                    } label: {
                        Image("cap (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .catEars
                    } label: {
                        Image("cat ears (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .chef
                    } label: {
                        Image("chef (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .crown
                    } label: {
                        Image("crown (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .devilHorns
                    } label: {
                        Image("devil horns (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                VStack {
                    Button {
                        activeAlert = .flowerCrown
                    } label: {
                        Image("flower crown (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .graduationHat
                    } label: {
                        Image("graduation hat (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .headphones
                    } label: {
                        Image("headphones (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .mexicanHat
                    } label: {
                        Image("mexican hat (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .partyHat
                    } label: {
                        Image("party hat (10c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .plant
                    } label: {
                        Image("plant (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                VStack {
                    Button {
                        activeAlert = .rabbitEars
                    } label: {
                        Image("rabbit ears (30c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .santaHat
                    } label: {
                        Image("santa hat (50c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .tiara
                    } label: {
                        Image("tiara (50c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .topHat
                    } label: {
                        Image("top hat (40c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .vikingHelmet
                    } label: {
                        Image("viking helmet (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button {
                        activeAlert = .witchHat
                    } label: {
                        Image("witch hat (20c)")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $profileImage, isImagePickerPresented: $isImagePickerPresented)
            }
        }
        .scaledToFit()
        .frame(height: 600)
        .frame(width: 400)
        .alert(item: $activeAlert) { activeAlert in
            switch activeAlert {
            case .noAvatar:
                return Alert(
                    title: Text("No Avatar"),
                    message: Text("You currently have no avatar."),
                    dismissButton: .cancel(Text("OK"))
                )
            case .bowTie:
                return accessoryAlert(cost: 10, accessory: "bow tie")
            case .cap:
                return accessoryAlert(cost: 10, accessory: "cap")
            case .catEars:
                return accessoryAlert(cost: 30, accessory: "cat ears")
            case .chef:
                return accessoryAlert(cost: 20, accessory: "chef")
            case .crown:
                return accessoryAlert(cost: 20, accessory: "crown")
            case .devilHorns:
                return accessoryAlert(cost: 30, accessory: "devil horns")
            case .flowerCrown:
                return accessoryAlert(cost: 10, accessory: "flower crown")
            case .graduationHat:
                return accessoryAlert(cost: 20, accessory: "graduation hat")
            case .headphones:
                return accessoryAlert(cost: 40, accessory: "headphones")
            case .mexicanHat:
                return accessoryAlert(cost: 40, accessory: "mexican hat")
            case .partyHat:
                return accessoryAlert(cost: 10, accessory: "party hat")
            case .plant:
                return accessoryAlert(cost: 30, accessory: "plant")
            case .rabbitEars:
                return accessoryAlert(cost: 30, accessory: "rabbit ears")
            case .santaHat:
                return accessoryAlert(cost: 50, accessory: "santa hat")
            case .tiara:
                return accessoryAlert(cost: 50, accessory: "tiara")
            case .topHat:
                return accessoryAlert(cost: 40, accessory: "top hat")
            case .vikingHelmet:
                return accessoryAlert(cost: 20, accessory: "viking helmet")
            case .witchHat:
                
                return accessoryAlert(cost: 20, accessory: "witch hat")
            case .profilePhoto:
                return Alert(
                    title: Text("Select Profile Photo"),
                    message: Text("Choose your own profile photo."),
                    primaryButton: .default(Text("Select")) {
                        openImagePicker()
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )

            }
        }
    }
    
    func openImagePicker() {
        isImagePickerPresented = true
    }
    func accessoryAlert(cost: Int, accessory: String) -> Alert {
        return Alert(
            title: Text("Accessory Purchase"),
            message: Text("This accessory costs \(cost) coins."),
            primaryButton: .default(Text("Buy")) {
                if coins >= cost {
                    coins -= cost
                    self.avatarImage = Image(accessory)
                } else {
                    // tell user that they don't have enough to buy
                }
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }
}



struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

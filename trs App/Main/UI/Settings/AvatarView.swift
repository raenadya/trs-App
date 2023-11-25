import SwiftUI

struct AvatarView: View {
    
    @State var showingAvatarView = false
    @State var avatarImage: Image = Image("defaultAvatar")
    @State private var profileImage: UIImage? = nil
    @State private var coins: Int = 100
    @State private var isImagePickerPresented: Bool = false
    
    @State private var showingPurchaseAlert = false
    @ObservedObject var coinsManager: CoinsManager = .shared
    
    enum AvatarItem: String, Identifiable, CaseIterable {
        case noAvatar = "noAvatar"
        case bowTie = "bow tie (10c)"
        case cap = "cap (10c)"
        case catEars = "cat ears (30c)"
        case chef = "chef (20c)"
        case crown = "crown (20c)"
        case devilHorns = "devil horns (30c)"
        case flowerCrown = "flower crown (10c)"
        case graduationHat = "graduation hat (20c)"
        case headphones = "headphones (40c)"
        case mexicanHat = "mexican hat (40c)"
        case partyHat = "party hat (10c)"
        case plant = "plant (30c)"
        case rabbitEars = "rabbit ears (30c)"
        case santaHat = "santa hat (50c)"
        case tiara = "tiara (50c)"
        case topHat = "top hat (40c)"
        case vikingHelmet = "viking helmet (20c)"
        case witchHat = "witch hat (20c)"
        case profilePhoto = "profile photo"
        
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
        ScrollView {
            ZStack {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .position(x: 130, y: 70)
                
            }
            
            let count = Int((UIScreen.main.bounds.width) / ((UIScreen.main.bounds.width - 60) / 3))
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: count), spacing: 15) {
                ForEach(AvatarItem.allCases, id: \.id) { item in
                    Image(item.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: (UIScreen.main.bounds.width - 60) / 3)
                }
            }
            .padding(.horizontal)
            
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
}



struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

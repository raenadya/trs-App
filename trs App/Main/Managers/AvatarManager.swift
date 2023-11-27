//
//  AvatarManager.swift
//  trs App
//
//  Created by Tristan Chay on 26/11/23.
//

import SwiftUI
import SwiftPersistence

enum AvatarItem: String, Identifiable, CaseIterable {
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
    
    var id: Int {
        switch self {
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
        }
    }
    
    var cost: Int {
        switch self {
        case .bowTie: return 10
        case .cap: return 10
        case .catEars: return 30
        case .chef: return 20
        case .crown: return 20
        case .devilHorns: return 30
        case .flowerCrown: return 10
        case .graduationHat: return 20
        case .headphones: return 40
        case .mexicanHat: return 40
        case .partyHat: return 10
        case .plant: return 30
        case .rabbitEars: return 30
        case .santaHat: return 50
        case .tiara: return 50
        case .topHat: return 40
        case .vikingHelmet: return 20
        case .witchHat: return 20
        }
    }
}

class AvatarManager: ObservableObject {
    static let shared: AvatarManager = .init()
    
    @Persistent("ownedAccessories") private var internalOwnedAccessories: [Int] = []
    @Persistent("avatarImageName") private var internalAvatarImageName: String? = nil
    
    @Published var ownedAccessories: [Int] = []
    @Published var avatarImageName: String? = nil
    
    init() {
        updatePublishedVariables()
    }
    
    func updatePublishedVariables() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.avatarImageName = self.internalAvatarImageName
            self.ownedAccessories = self.internalOwnedAccessories
        }
    }
    
    func updateAvatarImage(to newName: String?) {
        internalAvatarImageName = newName
        updatePublishedVariables()
    }
    
    func addOwnedAccessory(withID id: Int) {
        self.internalOwnedAccessories.append(id)
        updatePublishedVariables()
    }
}

//
//  CredentialsManager.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI
import SwiftPersistence

struct Experience: Codable, Identifiable {
    var id = UUID()
    var title: String
    var organiserName: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var additionalInformation: String?
    var tag: ExperienceTagType
}


enum ExperienceTagType: String, Codable, CaseIterable {
    case communityService = "Community Service"
    case leadership = "Leadership"
    case others = "Others"
}

struct Competition: Codable, Identifiable {
    var id = UUID()
    var title: String
    var organiserName: String
    var achievementLevel: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var tag: CompetitionTagType
}

enum CompetitionTagType: String, Codable, CaseIterable {
    case stem = "STEM"
    case humanities = "Humanities"
    case linguistics = "Linguistics"
    case arts = "Arts"
    case sports = "Sports"
    case others = "Others"
}

struct AchievementAndHonour: Codable, Identifiable {
    var id = UUID()
    var title: String
    var organiserName: String
    var achievementLevel: String
    var startDate: Date
    var endDate: Date
    var description: String?
}

struct Project: Codable, Identifiable {
    var id = UUID()
    var title: String
    var organiserName: String
    var startDate: Date
    var endDate: Date
    var description: String?
}

class CredentialsManager: ObservableObject {
    static let shared: CredentialsManager = .init()
    
    @Persistent("experiences") private var internalExperiences: [Experience] = []
    @Persistent("competitions") private var internalCompetitions: [Competition] = []
    @Persistent("achievementAndHonours") private var internalAchievementAndHonours: [AchievementAndHonour] = []
    @Persistent("projects") private var internalProjects: [Project] = []
    
    @Published var experiences: [Experience] = []
    @Published var competitions: [Competition] = []
    @Published var achievementAndHonours: [AchievementAndHonour] = []
    @Published var projects: [Project] = []
    
    init() {
        updatePublishedVariables()
    }
    
    func updatePublishedVariables() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.experiences = self.internalExperiences
            self.competitions = self.internalCompetitions
            self.achievementAndHonours = self.internalAchievementAndHonours
            self.projects = self.internalProjects
        }
    }
    
    func addToExperiences(withValue experience: Experience) {
        internalExperiences.append(experience)
        updatePublishedVariables()
    }
    
    func addToCompetitions(withValue competition: Competition) {
        internalCompetitions.append(competition)
        updatePublishedVariables()
    }
    
    func addToAchievementAndHonours(withValue achievementAndHonour: AchievementAndHonour) {
        internalAchievementAndHonours.append(achievementAndHonour)
        updatePublishedVariables()
    }
    
    func addToProjects(withValue project: Project) {
        internalProjects.append(project)
        updatePublishedVariables()
    }

    func removeCredential(forType type: CategoryType, atOffset offset: IndexSet) {
        switch type {
        case .all:
            break
        case .experiences:
            internalExperiences.remove(atOffsets: offset)
        case .competitions:
            internalCompetitions.remove(atOffsets: offset)
        case .achievementsAndHonours:
            internalAchievementAndHonours.remove(atOffsets: offset)
        case .projects:
            internalProjects.remove(atOffsets: offset)
        }
        updatePublishedVariables()
    }
}

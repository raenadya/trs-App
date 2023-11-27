//
//  CredentialsManager.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI
import SwiftPersistence

struct Experience: Codable, Identifiable {
    var dateAdded: Date
    var id = UUID()
    var title: String
    var organiserName: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var additionalInformation: String?
    var tag: ExperienceTagType
    var importance: Int
}

enum ExperienceTagType: String, Codable, CaseIterable {
    case communityService = "Community Service"
    case leadership = "Leadership"
    case others = "Others"
}

struct Competition: Codable, Identifiable {
    var dateAdded: Date
    var id = UUID()
    var title: String
    var organiserName: String
    var achievementLevel: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var tag: CompetitionTagType
    var importance: Int
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
    var dateAdded: Date
    var id = UUID()
    var title: String
    var organiserName: String
    var achievementLevel: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var importance: Int
}

struct Project: Codable, Identifiable {
    var dateAdded: Date
    var id = UUID()
    var title: String
    var organiserName: String
    var startDate: Date
    var endDate: Date
    var description: String?
    var importance: Int
}

enum Credential: Codable, Identifiable {
    case experience(Experience)
    case competition(Competition)
    case achievementAndHonour(AchievementAndHonour)
    case project(Project)
    
    var type: CategoryType {
        switch self {
        case .experience(_):
            return .experiences
        case .competition(_):
            return .competitions
        case .achievementAndHonour(_):
            return .achievementsAndHonours
        case .project(_):
            return .projects
        }
    }
    
    var dateAdded: Date {
        switch self {
        case .experience(let experience):
            return experience.dateAdded
        case .competition(let competition):
            return competition.dateAdded
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.dateAdded
        case .project(let project):
            return project.dateAdded
        }
    }

    var id: UUID {
        switch self {
        case .experience(let experience):
            return experience.id
        case .competition(let competition):
            return competition.id
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.id
        case .project(let project):
            return project.id
        }
    }

    var title: String {
        switch self {
        case .experience(let experience):
            return experience.title
        case .competition(let competition):
            return competition.title
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.title
        case .project(let project):
            return project.title
        }
    }

    var description: String? {
        switch self {
        case .experience(let experience):
            return experience.description
        case .competition(let competition):
            return competition.description
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.description
        case .project(let project):
            return project.description
        }
    }
    
    var organiserName: String {
        switch self {
        case .experience(let experience):
            return experience.organiserName
        case .competition(let competition):
            return competition.organiserName
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.organiserName
        case .project(let project):
            return project.organiserName
        }
    }
    
    var startDate: Date {
        switch self {
        case .experience(let experience):
            return experience.startDate
        case .competition(let competition):
            return competition.startDate
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.startDate
        case .project(let project):
            return project.startDate
        }
    }
    
    var endDate: Date {
        switch self {
        case .experience(let experience):
            return experience.endDate
        case .competition(let competition):
            return competition.endDate
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.endDate
        case .project(let project):
            return project.endDate
        }
    }
    
    var importance: Int {
        switch self {
        case .experience(let experience):
            return experience.importance
        case .competition(let competition):
            return competition.importance
        case .achievementAndHonour(let achievementAndHonour):
            return achievementAndHonour.importance
        case .project(let project):
            return project.importance
        }
    }

    static func == (lhs: Credential, rhs: Credential) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    struct MinimalRepresentation: Codable, Identifiable, Hashable {
        var id: UUID
        var title: String
        var description: String?
    }

    var minimalRepresentation: MinimalRepresentation {
        .init(id: id, title: title, description: description)
    }
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
    
    @ObservedObject var coinsManager: CoinsManager = .shared
    
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
        internalExperiences.insert(experience, at: 0)
        updatePublishedVariables()
    }
    
    func addToCompetitions(withValue competition: Competition) {
        internalCompetitions.insert(competition, at: 0)
        updatePublishedVariables()
    }
    
    func addToAchievementAndHonours(withValue achievementAndHonour: AchievementAndHonour) {
        internalAchievementAndHonours.insert(achievementAndHonour, at: 0)
        updatePublishedVariables()
    }
    
    func addToProjects(withValue project: Project) {
        internalProjects.insert(project, at: 0)
        updatePublishedVariables()
    }

    func removeCredential(forType type: CategoryType, withID id: UUID) {
        switch type {
        case .all:
            break
        case .experiences:
            guard let index = internalExperiences.firstIndex(where: { $0.id == id }) else { return }
            internalExperiences.remove(at: index)
        case .competitions:
            guard let index = internalCompetitions.firstIndex(where: { $0.id == id }) else { return }
            internalCompetitions.remove(at: index)
        case .achievementsAndHonours:
            guard let index = internalAchievementAndHonours.firstIndex(where: { $0.id == id }) else { return }
            internalAchievementAndHonours.remove(at: index)
        case .projects:
            guard let index = internalProjects.firstIndex(where: { $0.id == id }) else { return }
            internalProjects.remove(at: index)
        }
        updatePublishedVariables()
        coinsManager.removeCoins(amount: 5)
    }
}

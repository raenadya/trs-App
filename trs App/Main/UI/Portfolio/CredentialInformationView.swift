//
//  CredentialInformationView.swift
//  trs App
//
//  Created by Tristan Chay on 18/11/23.
//

import SwiftUI
import SwiftPersistence

struct CredentialInformationView: View {
    
    @State var title = ""
    @State var organiserName = ""
    @State var achievementLevel = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var importance = 0
    @State var tagRawValue = ""
    @State var description = ""
    @State var additionalInformation = ""
    
    @State var experienceTagSelection: ExperienceTagType = .communityService
    @State var competitionTagSelection: CompetitionTagType = .stem
    
    @State var credential: Credential
    @State var showingEditCredentialView = false
    
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    
    @Persistent("experiences") private var internalExperiences: [Experience] = []
    @Persistent("competitions") private var internalCompetitions: [Competition] = []
    @Persistent("achievementAndHonours") private var internalAchievementAndHonours: [AchievementAndHonour] = []
    @Persistent("projects") private var internalProjects: [Project] = []
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List {
            informationSection
            datesSection
            secondaryInformationSection
//            documentsSection
            importanceSection
            if credential.type == .experiences || credential.type == .competitions {
                tagSection
            }
        }
        .navigationTitle(credential.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .onChange(of: editMode?.wrappedValue.isEditing) { newValue in
            if newValue == false {
                saveCredential()
            }
        }
        .onAppear {
            title = credential.title
            organiserName = credential.organiserName
            switch credential {
            case .competition(let competition): 
                tagRawValue = competition.tag.rawValue
                achievementLevel = competition.achievementLevel
                competitionTagSelection = competition.tag
            case .achievementAndHonour(let achievementAndHonour):
                achievementLevel = achievementAndHonour.achievementLevel
            case .experience(let experience):
                additionalInformation = experience.additionalInformation ?? ""
                tagRawValue = experience.tag.rawValue
                experienceTagSelection = experience.tag
            case .project(_): break
            }
            startDate = credential.startDate
            endDate = credential.endDate
            importance = credential.importance
            description = credential.description ?? ""
        }
    }
    
    var informationSection: some View {
        Section("Information") {
            if editMode?.wrappedValue.isEditing == false {
                Text(title)
                Text(organiserName)
                if credential.type == .competitions || credential.type == .achievementsAndHonours {
                    Text(achievementLevel)
                }
            } else if editMode?.wrappedValue.isEditing == true {
                if credential.type.rawValue == "Achievements/Honours" {
                    TextField("Achievement/Honour Name",
                              text: $title)
                } else {
                    TextField("\(String(credential.type.rawValue.dropLast())) Name", text: $title)
                }
                TextField("Organiser Name", text: $organiserName)
                if credential.type == .achievementsAndHonours || credential.type == .competitions {
                    TextField("Achievement Level", text: $achievementLevel)
                }
            }
        }
    }
    
    var datesSection: some View {
        Section("Dates") {
            if editMode?.wrappedValue.isEditing == false {
                HStack {
                    Text("Start Date")
                    Spacer()
                    Text(startDate, style: .date)
                }
                HStack {
                    Text("End Date")
                    Spacer()
                    Text(endDate, style: .date)
                }
            } else if editMode?.wrappedValue.isEditing == true {
                DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
            }
        }
    }
    
    var secondaryInformationSection: some View {
        Section {
            if editMode?.wrappedValue.isEditing == false {
                if !description.isEmpty && description != " " {
                    Text(description)
                }
                if !additionalInformation.isEmpty && additionalInformation != " " && credential.type == .experiences {
                    Text(additionalInformation)
                }
            } else if editMode?.wrappedValue.isEditing == true {
                TextField("Description", text: $description, axis: .vertical)
                if credential.type == .experiences {
                    TextField("Additional Information (Service hours etc.)", text: $additionalInformation, axis: .vertical)
                }
            }
        }
    }
    
    var documentsSection: some View {
        Section("Documents") {
            // document
        }
    }
    
    var importanceSection: some View {
        Section("Importance") {
            if editMode?.wrappedValue.isEditing == false {
                RatingView(rating: $importance, label: "Importance", editable: false)
            } else if editMode?.wrappedValue.isEditing == true {
                RatingView(rating: $importance, label: "Importance", editable: true)
            }
        }
    }
    
    var tagSection: some View {
        Section("Tag") {
            if editMode?.wrappedValue.isEditing == false {
                Text(tagRawValue)
            } else if editMode?.wrappedValue.isEditing == true {
                if credential.type == .experiences {
                    Picker("Tag", selection: $experienceTagSelection) {
                        ForEach(ExperienceTagType.allCases, id: \.rawValue) { tag in
                            Text(tag.rawValue)
                                .tag(tag)
                        }
                    }
                } else if credential.type == .competitions {
                    Picker("Tag", selection: $competitionTagSelection) {
                        ForEach(CompetitionTagType.allCases, id: \.rawValue) { tag in
                            Text(tag.rawValue)
                                .tag(tag)
                        }
                    }
                }
            }
        }
    }
    
    func saveCredential() {
        switch credential {
        case .experience(let experience):
            let index = internalExperiences.firstIndex { $0.id == experience.id }
            guard let index = index else { return }
            internalExperiences[index] = Experience(dateAdded: experience.dateAdded,
                                                    id: experience.id,
                                                    title: title,
                                                    organiserName: organiserName,
                                                    startDate: startDate,
                                                    endDate: endDate,
                                                    description: description,
                                                    additionalInformation: additionalInformation,
                                                    tag: experienceTagSelection,
                                                    importance: importance)
            credentialsManager.updatePublishedVariables()
            
        case .competition(let competition):
            let index = internalCompetitions.firstIndex { $0.id == competition.id }
            guard let index = index else { return }
            internalCompetitions[index] = Competition(dateAdded: competition.dateAdded,
                                                      id: competition.id,
                                                      title: title,
                                                      organiserName: organiserName,
                                                      achievementLevel: achievementLevel,
                                                      startDate: startDate,
                                                      endDate: endDate,
                                                      description: description,
                                                      tag: competitionTagSelection,
                                                      importance: importance)
            credentialsManager.updatePublishedVariables()
            
        case .achievementAndHonour(let achievementAndHonour):
            let index = internalAchievementAndHonours.firstIndex { $0.id == achievementAndHonour.id }
            guard let index = index else { return }
            internalAchievementAndHonours[index] = AchievementAndHonour(dateAdded: achievementAndHonour.dateAdded,
                                                                        id: achievementAndHonour.id,
                                                                        title: title,
                                                                        organiserName: organiserName,
                                                                        achievementLevel: achievementLevel,
                                                                        startDate: startDate,
                                                                        endDate: endDate,
                                                                        description: description,
                                                                        importance: importance)
            credentialsManager.updatePublishedVariables()
            
        case .project(let project):
            let index = internalProjects.firstIndex { $0.id == project.id }
            guard let index = index else { return }
            internalProjects[index] = Project(dateAdded: project.dateAdded,
                                              id: project.id,
                                              title: title,
                                              organiserName: organiserName,
                                              startDate: startDate,
                                              endDate: endDate,
                                              description: description,
                                              importance: importance)
            credentialsManager.updatePublishedVariables()
        }
    }
}
    
//struct CredentialInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CredentialInformationView()
//    }
//}

//
//  NewCredentialsView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

struct NewCredentialsView: View {
    
    @Binding var showingAddCredentialView: Bool
    @Binding var showingCredentialInformation: Bool
    @Binding var navigationTitle: String
    @Binding var forType: CategoryType
    
    @State var title = ""
    @State var achievement = ""
    @State var organiser = ""
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var description = ""
    @State var additionalInfo = ""
    @State var documents = ""
    
    @State var competitionTagSelection: CompetitionTagType = .stem
    @State var experienceTagSelection: ExperienceTagType = .communityService
    
    @State var openFileDirectory = false
    
    @State var rating = 0
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    @ObservedObject var coinsManager: CoinsManager = .shared
    
    var disabled: Bool {
        switch forType {
        case .all:
            return true
        case .experiences:
            if !title.isEmpty && !organiser.isEmpty && rating > 0 {
                return false
            } else {
                return true
            }
        case .competitions:
            if !title.isEmpty && !organiser.isEmpty && !achievement.isEmpty && rating > 0 {
                return false
            } else {
                return true
            }
        case .achievementsAndHonours:
            if !title.isEmpty && !organiser.isEmpty && !achievement.isEmpty && rating > 0 {
                return false
            } else {
                return true
            }
        case .projects:
            if !title.isEmpty && !organiser.isEmpty && rating > 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        List {
            infoSection
            durationSection
            secondaryInfoSection
            documentsSection
            importanceSection
            if forType == .experiences || forType == .competitions {
                tagSection
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let calendar = Calendar(identifier: .gregorian)
            startDate = calendar.startOfDay(for: Date())
            endDate = calendar.startOfDay(for: Date())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addCredential()
                } label: {
                    Text("Add")
                }
                .disabled(disabled)
            }
        }
        .fileImporter(isPresented: $openFileDirectory,
                      
                      allowedContentTypes: [.text, .data, .html, .jpeg, .png, .json, .xml, .audio, .image, .pdf],
                      allowsMultipleSelection: true) { files in
            do {
                let fileURL = try files.get()
                print(fileURL)
                let fileName = fileURL.first?.lastPathComponent ?? "file not available"
                print(fileName)
            } catch {
                print("error reading file \(error.localizedDescription)")
            }
        }
    }
    
    var infoSection: some View {
        Section {
            if navigationTitle == "Achievements/Honours" {
                TextField("Achievement/Honour Name", text: $title)
            } else {
                TextField("\(String(navigationTitle.dropLast())) Name", text: $title)
            }
            TextField("Organiser Name", text: $organiser)
            if forType == .achievementsAndHonours || forType == .competitions {
                TextField("Achievement Level", text: $achievement)
            }
        } header: {
            Text("Information *")
        } footer: {
            if forType == .achievementsAndHonours {
                Text("e.g. Distinction/3rd/Silver")
            } else if forType == .competitions {
                Text("Don't worry if you didn't achieve an honour! The experience is still important.")
            }
        }
    }
    
    var durationSection: some View {
        Section("Dates *") {
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
        }
    }
    
    var secondaryInfoSection: some View {
        Section {
            TextField("Description", text: $description, axis: .vertical)
            if forType == .experiences {
                TextField("Additional Information (Service hours etc.)", text: $additionalInfo, axis: .vertical)
            }
        } footer: {
            switch forType {
            case .all:
                EmptyView()
            case .experiences:
                Text("Describe what the experience. For leadership, describe the event you lead/assist in, what you did & the result. For community service, state what you did to help others/environment etc & how long did you spent on it.")
            case .competitions:
                Text("Describe what the competition was about, what you experienced, the challenges you faced, and the insights you gained.")
            case .achievementsAndHonours:
                EmptyView()
            case .projects:
                Text("Describe the topic of the project, the research you did / experiment you conducted, conclusion & how this is linked to how you are as a person (passion, interest, etc)")
            }
        }
    }
    
    var documentsSection: some View {
        Section {
            Button("Add documents via Files") {
                openFileDirectory.toggle()
            }
        } header: {
            Text("Documents")
        } footer: {
            Text("Add any documents that you need.")
        }
    }
    
    var importanceSection: some View {
        Section {
            RatingView(rating: $rating, label: "Importance")
        } header: {
            Text("Importance *")
        } footer: {
            switch forType {
            case .experiences:
                Text("How important is this experience to your portfolio?")
            case .competitions, .achievementsAndHonours:
                Text("How important is this to your portfolio? Those in which you've attained high achievement levels, or are organised by large-scale companies, may come in handy more often.")
            case .projects:
                Text("How important is this project to your portfolio? Those in which you've done a lot of research/experiment, or are implemented in real life, may come in handy more often.")
            default:
                EmptyView()
            }
        }
    }
    
    var tagSection: some View {
        Section("Tag") {
            if forType == .experiences {
                Picker("Tag", selection: $experienceTagSelection) {
                    ForEach(ExperienceTagType.allCases, id: \.rawValue) { tag in
                        Text(tag.rawValue)
                            .tag(tag)
                    }
                }
            } else if forType == .competitions {
                Picker("Tag", selection: $competitionTagSelection) {
                    ForEach(CompetitionTagType.allCases, id: \.rawValue) { tag in
                        Text(tag.rawValue)
                            .tag(tag)
                    }
                }
            }
        }
    }
    
    func addCredential() {
        switch forType {
        case .all:
            break
        case .experiences:
            credentialsManager.addToExperiences(withValue: Experience(dateAdded: Date(),
                                                                      title: title,
                                                                      organiserName: organiser,
                                                                      startDate: startDate,
                                                                      endDate: endDate,
                                                                      description: description,
                                                                      additionalInformation: additionalInfo,
                                                                      tag: experienceTagSelection,
                                                                      importance: rating)
            )
            coinsManager.addCoins(amount: 5)
        case .competitions:
            credentialsManager.addToCompetitions(withValue: Competition(dateAdded: Date(),
                                                                        title: title,
                                                                        organiserName: organiser,
                                                                        achievementLevel: achievement,
                                                                        startDate: startDate,
                                                                        endDate: endDate,
                                                                        description: description,
                                                                        tag: competitionTagSelection,
                                                                        importance: rating)
            )
            coinsManager.addCoins(amount: 5)
        case .achievementsAndHonours:
            credentialsManager.addToAchievementAndHonours(withValue: AchievementAndHonour(dateAdded: Date(),
                                                                                          title: title,
                                                                                          organiserName: organiser,
                                                                                          achievementLevel: achievement,
                                                                                          startDate: startDate,
                                                                                          endDate: endDate,
                                                                                          description: description,
                                                                                          importance: rating)
            )
            coinsManager.addCoins(amount: 5)
        case .projects:
            credentialsManager.addToProjects(withValue: Project(dateAdded: Date(),
                                                                title: title,
                                                                organiserName: organiser,
                                                                startDate: startDate,
                                                                endDate: endDate,
                                                                description: description,
                                                                importance: rating)
            )
            coinsManager.addCoins(amount: 5)
        }
        showingCredentialInformation = false
        showingAddCredentialView = false
    }
    
}
    //struct NewCredentialsView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        NewCredentialsView()
    //    }
    //}

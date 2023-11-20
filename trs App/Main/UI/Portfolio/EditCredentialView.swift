//
//  EditCredentialView.swift
//  trs App
//
//  Created by Kierae NJ on 20/11/23.
//

import SwiftUI

struct EditCredentialView: View {
    
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
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var credentialsManager: CredentialsManager = .shared
    
    var disabled: Bool {
        switch forType {
        case .all:
            return true
        case .experiences:
            if !title.isEmpty && !organiser.isEmpty {
                return false
            } else {
                return true
            }
        case .competitions:
            if !title.isEmpty && !organiser.isEmpty && !achievement.isEmpty {
                return false
            } else {
                return true
            }
        case .achievementsAndHonours:
            if !title.isEmpty && !organiser.isEmpty && !achievement.isEmpty {
                return false
            } else {
                return true
            }
        case .projects:
            if !title.isEmpty && !organiser.isEmpty {
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
            tagSection
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
        } footer: {
            if forType == .achievementsAndHonours {
                Text("e.g. Distinction/3rd/Silver")
            } else if forType == .competitions {
                Text("Don't worry if you didn't achieve an honour! The experience is still important.")
            }
        }
    }
    
    var durationSection: some View {
        Section {
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
        }
    }
    
    var secondaryInfoSection: some View {
        Section {
            TextField("Description", text: $description, axis: .vertical)
            if forType == .experiences {
                additionalInfoSection
            }
        }
    }
    
    var additionalInfoSection: some View {
        TextField("Additional Information", text: $additionalInfo, axis: .vertical)
    }
    
    var documentsSection: some View {
        Section {
            Button("Add documents via Files") {
                openFileDirectory.toggle()
            }
        } footer: {
            Text("Add any documents that you need.")
        }
    }
    
    var importanceSection: some View {
        Section {
            TextField("Importance", text: $documents)
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
        Section {
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
                                                                      tag: experienceTagSelection)
            )
        case .competitions:
            credentialsManager.addToCompetitions(withValue: Competition(dateAdded: Date(),
                                                                        title: title,
                                                                        organiserName: organiser,
                                                                        achievementLevel: achievement,
                                                                        startDate: startDate,
                                                                        endDate: endDate,
                                                                        description: description,
                                                                        tag: competitionTagSelection)
            )
        case .achievementsAndHonours:
            credentialsManager.addToAchievementAndHonours(withValue: AchievementAndHonour(dateAdded: Date(),
                                                                                          title: title,
                                                                                          organiserName: organiser,
                                                                                          achievementLevel: achievement,
                                                                                          startDate: startDate,
                                                                                          endDate: endDate,
                                                                                          description: description)
            )
        case .projects:
            credentialsManager.addToProjects(withValue: Project(dateAdded: Date(),
                                                                title: title,
                                                                organiserName: organiser,
                                                                startDate: startDate,
                                                                endDate: endDate,
                                                                description: description)
            )
        }
        showingCredentialInformation = false
        showingAddCredentialView = false
    }
}

//struct NewCredentialsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCredentialsView()
//    }
//}

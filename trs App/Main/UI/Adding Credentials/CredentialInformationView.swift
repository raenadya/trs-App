//
//  CredentialInformationView.swift
//  trs App
//
//  Created by Tristan Chay on 17/11/23.
//

import SwiftUI

enum CompetitionTagType: String, CaseIterable {
    case stem = "STEM"
    case humanities = "Humanities"
    case linguistics = "Linguistics"
    case arts = "Arts"
    case sports = "Sports"
    case others = "Others"
}

enum ExperienceTagType: String, CaseIterable {
    case communityService = "Community Service"
    case leadership = "Leadership"
    case others = "Others"
}

struct CredentialInformationView: View {
    
    @State var navigationTitle: String
    @State var forType: CategoryType
  
    @State var title = ""
    @State var achievement = ""
    @State var organiser = ""
    
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var description = ""
    @State var additionalInfo = ""
    @State var documents = ""
    
    @State var competitiontagSelection: CompetitionTagType = .stem
    @State var experiencetagSelection: ExperienceTagType = .communityService
    
    
    @State var openFileDirectory = false
    
    var body: some View {
        List {
            infoSection
            durationSection
            secondaryInfoSection
            documentsSection
            tagSection
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
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let calendar = Calendar(identifier: .gregorian)
            startDate = calendar.startOfDay(for: Date())
            endDate = calendar.startOfDay(for: Date())
        }
    }
    
    var infoSection: some View {
        Section {
            TextField("\(String(navigationTitle.dropLast())) Name", text: $title)
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
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
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
                Picker("Tag", selection: $experiencetagSelection) {
                    ForEach(ExperienceTagType.allCases, id: \.rawValue) { tag in
                        Text(tag.rawValue)
                            .tag(tag)
                    }
                }
            } else if forType == .competitions {
                Picker("Tag", selection: $competitiontagSelection) {
                    ForEach(CompetitionTagType.allCases, id: \.rawValue) { tag in
                        Text(tag.rawValue)
                            .tag(tag)
                    }
                }
            }
        }
    }
}

//struct CredentialInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CredentialInformationView()
//    }
//}

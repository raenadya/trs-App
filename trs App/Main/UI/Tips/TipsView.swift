//
//  TipsView.swift
//  trs App
//
//  Created by Kierae NJ on 18/11/23.
//

import SwiftUI

struct TipsView: View {
    let slides: [CategoryType: [String]] = [
        .all: ["All Slide 1", "All Slide 2", "All Slide 3"],
        .experiences: ["Experiences Slide 1", "Experiences Slide 2", "Experiences Slide 3"],
        .competitions: ["Competitions Slide 1", "Competitions Slide 2", "Competitions Slide 3"],
        .achievementsAndHonours: ["Achievements Slide 1", "Achievements Slide 2", "Achievements Slide 3"],
        .projects: ["Projects Slide 1", "Projects Slide 2", "Projects Slide 3"]
    ]

    @State private var currentSlide = 0
    @State var currentSelection: CategoryType

    var body: some View {
        VStack {
            TabView(selection: $currentSlide) {
                ForEach(slides[currentSelection]!, id: \.self) { slide in
                    Text(slide)
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onTapGesture {
                print("Tapped on slide \(currentSlide)")
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < 0 {
                            // swipe left
                            currentSlide = min(currentSlide + 1, slides.count - 1)
                        } else if value.translation.width > 0 {
                            // swipe right
                            currentSlide = max(currentSlide - 1, 0)
                        }
                    }
            )
        }
    }
                
                
}
            


struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(currentSelection: CategoryType.all)
    }
}

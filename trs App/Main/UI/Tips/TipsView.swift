//
//  TipsView.swift
//  trs App
//
//  Created by Kierae NJ on 18/11/23.
//

import SwiftUI

struct TipsView: View {
    let slides: [CategoryType: [String]] = [
        .all: ["Do extensive research on the company or school you’re applying to, ensuring alignment with your goals. Specify your interests in your portfolio if necessary.",
               "Focus on key strengths, achievements, and experiences. Avoid irrelevant information to keep your portfolio concise and impactful.",
               "Use numbers and statistics to quantify accomplishments for increased credibility. For example, specify percentage improvements rather than generic statements like 'improved team performance by 20%.'",
               "Maintain integrity by avoiding exaggeration. Be genuine in showcasing your true abilities.",
               "Personalize your portfolio by revealing unique aspects of your personality, passions, and aspirations. Avoid generic statements and provide a holistic view of who you are."],
        .experiences: ["Employ the STAR method to structure your experience descriptions, providing a clear narrative of the Situation, Task, Action, and Result.",
                       "Use impactful verbs (e.g., 'taught,' 'led,' 'organized') to emphasize your experiences.",
                       "Select experiences aligning with the values and goals of the program or institution to which you are applying.",
                       "Highlight instances of leadership and explain how you influenced positive outcomes, showcasing valuable skills.",
                       "Provide concrete situations and results to demonstrate the real-world impact of your experiences."],
        .competitions: ["Specify the competition's name and provide context to help the reader understand its significance and your participation.",
                        "Clearly state your role, emphasizing your specific responsibilities and impact on the competition.",
                        "Quantify achievements, such as awards or rankings, to provide a measurable understanding of positive outcomes.",
                        "Connect the competition experience to your personal and academic growth by discussing skills developed and lessons learned.",
                        "Relate the competition experience to your future goals, explaining how gained skills align with your academic or career aspirations."],
        .achievementsAndHonours: ["Clearly list and summarize achievements for straightforward communication.",
                                  "Explain the significance of each achievement by detailing criteria or standards for recognition.",
                                  "Specify dates to offer a chronological perspective, showcasing the consistency of accomplishments.",
                                  "Present a balanced portfolio by highlighting achievements in both academic and extracurricular domains.",
                                  "Connect each achievement to personal growth, emphasizing the broader impact on your skills and goals."],
        .projects: ["Use the UN's Sustainable Development Goals to define your project's problem, showcasing a global perspective and commitment to addressing important issues.",
                    "Highlight the mix of skills from different areas your project required, demonstrating versatility and knowledge integration.",
                    "Turn your project description into a captivating story, emphasizing the journey, challenges, and resolutions for an engaging and memorable portfolio.",
                    "Showcase your process of refining your approach as the project evolved, demonstrating the ability to learn from experiences and continuously improve strategies.",
                    "Connect the project to your personal growth and passions, explaining how it influenced academic and personal development, showcasing motivation and commitment to learning."]
    ]
    
    
    @State private var currentSlide = 0
    @State var currentSelection: CategoryType
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $currentSlide) {
                    ForEach(slides[currentSelection]!.indices, id: \.self) { i in
                        Text(slides[currentSelection]![i])
                            .tag(i)
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(30)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
            }
            .navigationTitle(currentSelection.rawValue)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(currentSelection: CategoryType.all)
    }
}

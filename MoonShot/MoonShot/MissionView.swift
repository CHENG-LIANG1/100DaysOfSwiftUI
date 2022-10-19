//
//  MissionView.swift
//  MoonShot
//
//  Created by Cheng Liang(Louis) on 2022/9/6.
//

import SwiftUI


struct MissionView: View {
    
    let mission: Mission
    

    let crew: [CrewMember]

    
    var body: some View {
        GeometryReader {geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.formattedlaunchDate)
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(.darkBackground)
                        .font(.custom("ArialRoundedMTBold", size: 18))
                        .background(.white)
                        .clipShape(Capsule())
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        
                    
                    
                    RectangleDivider()
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        RectangleDivider()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    

                    MissionScrollView(crew: crew)

                }
                .padding(.bottom)

            }
            
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            
            if let astro = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astro)
            }else {
                fatalError()
            }
            
        }
    }
    
    
}

//struct MissionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionView()
//    }
//}

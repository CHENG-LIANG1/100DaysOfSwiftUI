//
//  ContentView.swift
//  MoonShot
//
//  Created by Cheng Liang(Louis) on 2022/8/28.
//

import SwiftUI

struct MissionCell: View {
    var mission: Mission
    var astronauts: [String: Astronaut]
    var body: some View {
        
        NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
            
        } label: {
            VStack {
                
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()
                
                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(mission.formattedlaunchDate)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10) .stroke(.lightBackground))
            .padding(.vertical)
            
        }

    }
}


struct ContentView: View {

    let missions: [Mission]  = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronaut.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showGrid = true
    
    var body: some View {
        NavigationView{
            ScrollView {
                showGrid ?
                
                AnyView(
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            MissionCell(mission: mission, astronauts: astronauts)
                        }
        
                    }
                    .padding([.horizontal, .bottom])
      
                )
            
                :
                
                AnyView(
                    LazyVStack {
                        ForEach(missions) { mission in
                            MissionCell(mission: mission, astronauts: astronauts)
                        }
                    }
                    .padding([.horizontal, .bottom])

                )

                
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        showGrid.toggle()
                        
                    }) {
                        Text("Toggle")
                            .foregroundColor(.white)
                            .font(.custom("ArialRoundedMTBold", size: 16))
                        
                    }
                        }
                    }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

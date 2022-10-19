//
//  MissionScrollView.swift
//  MoonShot
//
//  Created by Cheng Liang(Louis) on 2022/9/8.
//

import SwiftUI

struct MissionScrollView: View {

    let crew: [CrewMember]
    
    @State private var presentSheet = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crew in
                    
                    Button(){
                        presentSheet = true
                    }label: {
                        HStack {
                            Image(crew.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crew.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crew.role)
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .sheet(isPresented: $presentSheet) {
                            
                            
                            VStack(alignment: .leading){
                                VStack(alignment: .center) {
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                    Text(crew.astronaut.name)
                                        .font(.title2.bold())
                                        .foregroundColor(.white)
                                        .padding(.vertical)

                                }
                                Text(crew.astronaut.description)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)

                            }
                            .padding()
                            
                                .presentationDetents([.large])
                        }
                    }
                    
                    
                }
            }
        }
    }
}

//struct MissionScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionScrollView()
//    }
//}

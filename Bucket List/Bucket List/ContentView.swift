//
//  ContentView.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/10/31.
//

import SwiftUI
import MapKit
import LocalAuthentication




struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    
    
    var body: some View {

        if !viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()

                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                    
                    
                }
                    .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.7)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.white)
                                .foregroundColor(.black.opacity(0.8))
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
       
                        
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace){ place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }

        }else {
            Button("Unlock Places"){
                viewModel.authenticate()

            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

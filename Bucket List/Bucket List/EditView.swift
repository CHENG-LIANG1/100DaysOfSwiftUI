//
//  EditView.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/11/3.
//

import SwiftUI

struct EditView: View {
    
    @StateObject private var viewModel = ViewModel()




    @Environment(\.dismiss) var dismiss
    
    var location: Location
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        self.location = location
        self.onSave = onSave

    }
    

    
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby..."){
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .success:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: location)
            }
            .onAppear {
                viewModel.name = location.name
                viewModel.description = location.description
            }
        }
    }
}

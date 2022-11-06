//
//  ContentView-ViewModel.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/11/5.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @Published var locations: [Location]
        @Published var selectedPlace: Location?
         var isUnlocked = false
        @Published var showingAlert = false
        
        let savePath = FileManager.documentDirectory.appendingPathExtension("SavedPlaces")
        
        init() {
            
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }

        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save")
            }
        }
        
        
        func addLocation(){
            let newLocation = Location(id: UUID(), name: "New location", description: " ", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            
            guard let selectedPlace = selectedPlace else {return}
            
            
            if let index = locations.firstIndex(of: selectedPlace){
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "Please autenticate yourself to unlock your places"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success , auntenticationError in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                            print("unlocked")
                        }
                
                    }else {
                        self.showingAlert = true
                        
                    }
                }
            }
        }
    }
    
    
    
    
}



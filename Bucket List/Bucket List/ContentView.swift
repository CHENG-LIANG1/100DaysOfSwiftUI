//
//  ContentView.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/10/31.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct User: Identifiable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
    let id = UUID()
    let firstName: String
    let lastName: String

}


enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success.")
    }
}


struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

//struct Location: Identifiable {
//    let id = UUID()
//
//    let name: String
//
//    let coordinate: CLLocationCoordinate2D
//}
//


struct ContentView: View {
    
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kobe"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
//    let locations = [
//        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
//
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var loadingState = LoadingState.loading
    
    @State private var isUnlocked = false
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?
    
    
    func authenticate() {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data" // this is for touch id
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                }
            }
        }
    }
    
    var body: some View {
//        Text("Hello, world!")
//            .onTapGesture {
//                let str = "Test Message"
//                let url = getDocumentsDirectory().appendingPathExtension("message.txt")
//
//                do {
//                    try str.write(to: url, atomically: true, encoding: .utf8 )
//
//                    let input = try String(contentsOf: url)
//                    print(input)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
        
        
//        if loadingState == .loading {
//            LoadingView()
//        } else if loadingState == .success {
//            SuccessView()
//        } else if loadingState == .failed {
//            FailedView()
//        }
        
//        NavigationView {
//            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//                MapAnnotation(coordinate: location.coordinate) {
//
//
//                    NavigationLink {
//                        Text(location.name)
//                    } label: {
//                        Circle()
//                            .stroke(.red, lineWidth: 4)
//                            .frame(width: 44, height: 44)
//                    }
//
//
//
//
//                }
//
//            }
//        }
        
//        VStack {
//            if isUnlocked {
//                Text("Unlocked")
//            } else {
//                Text("Locked")
//            }
//        }
//        .onAppear(perform: authenticate)

        
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
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
                        selectedPlace = location
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
                        let newLocation = Location(id: UUID(), name: "New location", description: " ", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                        
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.white)
                    .foregroundColor(.black.opacity(0.8))
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    
                }
            }
        }
        .sheet(item: $selectedPlace){ place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place){
                    locations[index] = newLocation
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

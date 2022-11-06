//
//  EditView-ViewModel.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/11/6.
//

import Foundation
import SwiftUI

extension EditView {
    @MainActor class ViewModel: ObservableObject {
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
        
        
        @Published var name = ""
        @Published var description = ""
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init() {
        }
        
        func fetchNearbyPlaces(location: Location) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .success
            } catch {
                loadingState = .failed
            }
        }

        
        
    }
}

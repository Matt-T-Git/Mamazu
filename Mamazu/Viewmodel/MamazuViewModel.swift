//
//  MamazuViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 17.03.2021.
//

import Foundation
import SwiftUI
import Combine

class MamazuViewModel: ObservableObject {
    
    @Published var mamazu = [MamazuResults]()
    @Published var errorMessage: String = ""
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    @Published var isLoading: Bool = false
    
    @ObservedObject var locationService = LocationManager()
    private var mamazuService = NetworkService()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        self.isLoading = true
        guard let lat = self.locationService.lastLocation?.coordinate.latitude,
              let lng = self.locationService.lastLocation?.coordinate.longitude else { return }
        let parameters = ["latitude": lat, "longitude": lng]
        
        mamazuService.fetchCombineDataWithParameters(params: parameters, urlString: POSTS_URL)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.isLoading = false
                    self.isError = true
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (result: Mamazu) in
                print(result.error)
                self?.mamazu = result.results
                self?.isFetched = true
                self?.isLoading = false
            }).store(in: &cancellables)
    }
    
    func fetchCurrentUsersMamazuLocations() {
        self.isLoading = true
        mamazuService.fetchCombineData(urlString: CURRENT_USER_POSTS_URL)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] (model: Mamazu) in
                self?.mamazu = model.results
                self?.isFetched = true
                self?.isLoading = false
            }).store(in: &cancellables)
    }
}

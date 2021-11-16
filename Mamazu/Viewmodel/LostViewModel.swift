//
//  LostViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 16.03.2021.
//

import Foundation
import SwiftUI
import Combine

class LostViewModel: ObservableObject {
    
    @Published var lost = [LostAnimalResults]()
    @Published var errorMessage: String = ""
    @Published var id: String = ""
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    
    @ObservedObject var locationService = LocationManager()
    private var lostService = NetworkService()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        
        guard let lat = self.locationService.lastLocation?.coordinate.latitude,
              let lng = self.locationService.lastLocation?.coordinate.longitude else { return }
        let parameters = ["latitude": lat, "longitude": lng]
        
        lostService.fetchCombineDataWithParameters(params: parameters, urlString: POSTS_URL)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                     self.isError = true
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (result: Lost) in
                print(result.error)
                self?.lost = result.results
                self?.isFetched = true
            }).store(in: &cancellables)
    }
    
    func fetchCurrentUsersLostLocations() {
        lostService.fetchCombineData(urlString: CURRENT_USER_LOST_ANIMAL_URL)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] (model: Lost) in
                self?.lost = model.results
                self?.isFetched = true
            }).store(in: &cancellables)
    }
    
    func found() {
        self.lostService.setFound(postId: id) { (success) in
            if success {
                self.isError = true
                self.errorMessage = LocalizedString.Errors.notificationSuccessfullySaved
            }else {
                self.isError = true
                self.errorMessage = LocalizedString.Errors.somethingWentWrongTryAgain
            }
        }
    }
    
}

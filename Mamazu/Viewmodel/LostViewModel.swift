//
//  LostViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 16.03.2021.
//

import Foundation
import SwiftUI

class LostViewModel: ObservableObject {
    
    @Published var lost = [LostAnimalResults]()
    @Published var losted: String = ""
    @Published var errorMessage: String = ""
    @Published var id: String = ""
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    
    @ObservedObject var locationService = LocationManager()
    private var lostService = NetworkService()
    
    func getLostData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            let parameters = ["latitude": self.locationService.lastLocation?.coordinate.latitude, "longitude": self.self.locationService.lastLocation?.coordinate.longitude]
            self.lostService.fetchDataWithParameters(params: parameters as NetworkService.params, urlString: LOST_LOCATION_URL) { [weak self] (response: Result<Lost, APIError>) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    DispatchQueue.main.async {
                        self?.lost = result.results
                        self?.isFetched = true
                    }
                }
            }
        }
    }
    
    func fetchCurrentUsersLostLocations() {
        self.lostService.fetchData(urlString: CURRENT_USER_LOST_ANIMAL_URL) { (response: Result<Lost, APIError>) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.lost = result.results
                self.isFetched = true
                self.isFetched = true
                print(result.results.count)
            }
        }
    }
    
    func found() {
        self.lostService.setFound(postId: id) { (success) in
            if success {
                self.isError = true
                self.errorMessage = "🥰 Bildiriminiz başarı ile kaydedildi. Birdaha ayrılmamanız dileği ile 🥰"
            }else {
                self.isError = true
                self.errorMessage = "Bir Hata Oluştu. Lütfen Daha Sonra Tekrar Deneyin."
            }
        }
    }
    
}

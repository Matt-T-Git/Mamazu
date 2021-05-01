//
//  MamazuViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 17.03.2021.
//

import Foundation
import SwiftUI

class MamazuViewModel: ObservableObject {
    
    @Published var mamazu = [MamazuResults]()
    @Published var losted: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    @Published var isLoading: Bool = false
    
    @ObservedObject var locationService = LocationManager()
    private var mamazuService = NetworkService()
    
    func fetchMamazuLocations() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            guard let lat = self.locationService.lastLocation?.coordinate.latitude,
                  let lng = self.locationService.lastLocation?.coordinate.longitude else { return }
            
            let parameters = ["latitude": lat, "longitude": lng]
            
            self.mamazuService.fetchDataWithParameters(params: parameters, urlString: POSTS_URL) { [weak self] (response: Result<Mamazu, APIError>) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    self?.mamazu = result.results
                    self?.isLoading = false
                    self?.isFetched = true
                }
            }
        }
    }
    
    func fetchCurrentUsersMamazuLocations() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.mamazuService.fetchData(urlString: CURRENT_USER_POSTS_URL) { (response: Result<Mamazu, APIError>) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    self.mamazu = result.results
                    self.isLoading = false
                    self.isFetched = true
                    print(result.results.count)
                }
            }
        }
    }
}

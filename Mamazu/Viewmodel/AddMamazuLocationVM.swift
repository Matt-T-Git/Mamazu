//
//  AddMamazuLocationVM.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 23.03.2021.
//

import Foundation
import SwiftUI
import Combine

class AddMamazuLocationVM: ObservableObject {
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var image: UIImage = UIImage()
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    @State private var showingAlert = false
    
    private var networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    typealias params = Dictionary<String, Any>
    
    func add() {
        if title.isEmpty || description.isEmpty || image.size == .zero {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.fullFill
            return
        }
        
        if latitude == 0.0 || longitude == 0.0 {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.locationServiceError
            return
        }
        self.isLoading = true
        
        let parameters: params = [
            "title": title,
            "description": description,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        networkService.addLocation(ADD_POST, parameters: parameters, image: image)
            .sink(receiveCompletion: { completion in
                print(completion)
                if case let .failure(error) = completion {
                    self.showAlertMessage(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (result: MamazuResult) in
                print(result)
                if result.error{
                    self?.showAlertMessage(result.message ?? "Add Location Error")
                }
                self?.isLoading = false
                self?.isSuccess = true
            }).store(in: &cancellables)
    }
    
    fileprivate func showAlertMessage(_ message: String) {
        self.isLoading = false
        self.isError.toggle()
        self.errorMessage = message
    }
}

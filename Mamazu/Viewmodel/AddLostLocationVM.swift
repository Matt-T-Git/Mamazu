//
//  AddLostLocationVM.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.03.2021.
//

import Foundation
import Combine
import SwiftUI

class AddLostLocationVM: ObservableObject {
    
    @Published var petName: String = ""
    @Published var description: String = ""
    @Published var image: UIImage = UIImage()
    @Published var petAge: String = ""
    @Published var petGender: String = ""
    @Published var petBreed: String = ""
    
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    @Published var isLocationSelected: Bool = false
    @Published var isError: Bool = false
    @Published var isSuccess: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isLoading: Bool = false
    @State private var showingAlert = false
    
    private var networkService = NetworkService()
    
    private var cancellables = Set<AnyCancellable>()
    typealias params = Dictionary<String, Any>
    
    @Published var selected: String? = nil
    
    var petAgeArray = Array(stride(from: 1, through: 30, by: 0.5))
        .map { String($0) }
        .map {$0.replacingOccurrences(of: ".0", with: "") }
    
    let petGenderArray = [LocalizedString.AddLocation.choose,
                          LocalizedString.AddLocation.male,
                          LocalizedString.AddLocation.female]
    
    init() {
        petAgeArray.insert(LocalizedString.AddLocation.choose, at: 0)
        petAgeArray.insert(LocalizedString.AddLocation.underAge, at: 1)
    }
    
    func addLostPet() {
        
        if petName.isEmpty || description.isEmpty || petBreed.isEmpty || petAge.isEmpty {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.fullFill
            return
        }
        
        if image.size == .zero {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.addImage
            return
        }
        
        if petGender.isEmpty || petGender == LocalizedString.AddLocation.choose {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.chooseGender
            return
        }
        
        if petAge.isEmpty || petAge == LocalizedString.AddLocation.choose {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.chooseAge
            return
        }
        
        if !isLocationSelected {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.chooseLocationOnMap
            return
        }
        
        if latitude == 0.0 || longitude == 0.0 {
            self.isError.toggle()
            self.errorMessage = LocalizedString.AddLocation.locationServiceError
            return
        }
        self.isLoading = true
        
        let parameters: params = [
            "petName": petName,
            "petBreed": petBreed,
            "petGender": petGender,
            "petAge": petAge,
            "description": description,
            "latitude": latitude,
            "longitude": longitude,
        ]
        
        networkService.addLocation(ADD_LOST_ANIMAL, parameters: parameters, image: image)
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

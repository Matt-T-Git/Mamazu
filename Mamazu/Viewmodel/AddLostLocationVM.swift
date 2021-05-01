//
//  AddLostLocationVM.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.03.2021.
//

import Foundation

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
    
    @Published var selected: String? = nil
    
    var petAgeArray = Array(stride(from: 1, through: 30, by: 0.5)).map { String($0) }.map {$0.replacingOccurrences(of: ".0", with: "") }
    let petGenderArray = ["SEÇİNİZ","Erkek", "Dişi"]
    
    init() {
        petAgeArray.insert("SEÇİNİZ", at: 0)
        petAgeArray.insert("1 Yaşından Küçük", at: 1)
    }
    
    func addLostPet() {
        
        if petName.isEmpty || description.isEmpty || petBreed.isEmpty || petAge.isEmpty {
            self.isError.toggle()
            self.errorMessage = "Lütfen tüm alanları doldurun..."
            return
        }
        
        if image.size == .zero {
            self.isError.toggle()
            self.errorMessage = "Lütfen fotoğraf Ekleyin..."
            return
        }
        
        if petGender.isEmpty || petGender == "SEÇİNİZ" {
            self.isError.toggle()
            self.errorMessage = "Lütfen cinsiyet Seçimini Yapın..."
            return
        }
        
        if petAge.isEmpty || petAge == "SEÇİNİZ" {
            self.isError.toggle()
            self.errorMessage = "Lütfen yaş Seçimini Yapın..."
            return
        }
        
        if !isLocationSelected {
            self.isError.toggle()
            self.errorMessage = "Lütfen harita üzerine dokunarak açılan pencerede parmağınızı dostumuzun kaybolduğu düşündüğünüz konuma 1 saniye kadar basılı tutun"
            return
        }
        
        if latitude == 0.0 || longitude == 0.0 {
            self.isError.toggle()
            self.errorMessage = "Konum servisine ulaşılırken bir sorun oluştu."
            return
        }
        self.isLoading = true
        
        networkService.addLostPetLocation(image: image,
                                             petName: petName,
                                             petBreed: petBreed,
                                             petGender: petGender,
                                             petAge: petAge,
                                             description: description,
                                             latitude: latitude,
                                             longitude: longitude) { (response: Result<LostAnimalResult, APIError>) in
            
            
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.isError.toggle()
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            case .success(_):
                self.isLoading = false
                self.isSuccess = true
            }
        }
    }
}

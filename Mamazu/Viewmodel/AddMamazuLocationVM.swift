//
//  AddMamazuLocationVM.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 23.03.2021.
//

import Foundation
import SwiftUI

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
    
    
    func addMamazu() {
        
        if title.isEmpty || description.isEmpty || image.size == .zero {
            self.isError.toggle()
            self.errorMessage = "Lütfen tüm alanları doldurun..."
            return
        }
        
        if latitude == 0.0 || longitude == 0.0 {
            self.isError.toggle()
            self.errorMessage = "Konum Servisine ulaşılırken bir sorun oluştu."
            return
        }
        self.isLoading = true
        networkService.addNewLocation(image: image, title: title, description: description, latitude: latitude, longitude: longitude) { (response: Result<MamazuResult, APIError>) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.isError.toggle()
                self.errorMessage = error.localizedDescription
            case .success(_):
                self.isLoading = false
                self.isSuccess = true
            }
        }
    }
}

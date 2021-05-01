//
//  UserViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI

class UserViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var imageUrl: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    @Published var isLoading: Bool = false
    
    //For lost pet detail view
    @AppStorage("userId") var userID = "0"
    
    private var userService = NetworkService()
    
    func getUserInfo() {
        isLoading = true
        userService.fetchData(urlString: CURRENT_USER_URL) { [weak self] (response: Result<UserModel, APIError>) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self?.isError = true
                self?.errorMessage = error.localizedDescription
                self?.isLoading = false
            case .success(let res):
                self?.userName = res.name
                self?.imageUrl = res.profileImg
                self?.userID = res.id
                self?.isFetched = true
                self?.isLoading = false
            }
        }
    }
}

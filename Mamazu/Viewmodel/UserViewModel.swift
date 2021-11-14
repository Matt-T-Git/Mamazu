//
//  UserViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var imageUrl: String = ""
    @Published var errorMessage: String = ""
    @Published var userlele: UserModel?
    
    @Published var isError: Bool = false
    @Published var isFetched: Bool = false
    @Published var isLoading: Bool = false
    
    //For lost pet detail view
    @AppStorage("userId") var userID = "0"
    
    private var userService = NetworkService()
    
    var cancellables = Set<AnyCancellable>()
    
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
    
    func getCombineUserInfo(){
        userService.fetchCombineData(urlString: CURRENT_USER_URL)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] (model: UserModel) in
                self?.userName = model.name
                self?.imageUrl = model.profileImg
                self?.userID = model.id
                self?.isFetched = true
                self?.isLoading = false
            }).store(in: &cancellables)
        
        //            .sink { completion in
        //                print(completion)
        //            } receiveValue: { user: UserModel in
        //                self?.userName = user.name
        //                self?.userID = user.id
        //                self?.imageUrl = user.profileImg
        //                self?.isFetched = true
        //                self?.isLoading = false
        //            }
        
    }
}

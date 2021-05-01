//
//  RegisterViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import UIKit
import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var image: UIImage = UIImage()
    @Published var errorMessage: String = ""
    
    @Published var isRegisterError: Bool = false
    @Published var isRegistered: Bool = false
    
    @Published var isLoading: Bool = false
    @State private var showingAlert = false
    
    private var registerService = RegisterService()
    private var loginService = LoginService()
    
    func registerUser() {
        print("Register Tapped...")
        self.isLoading = true
        // MARK:- Register user
        registerService.registerUser(name: name, email: email, password: password, profileImg: image) { (result) in
            switch result {
            case .success(_):
                
                // MARK:- Login user when register is success
                self.isLoading = false
                self.loginService.loginUser(email: self.email, password: self.password) { (result) in
                    switch result {
                    case .success(let loginData):
                        //Save user token to userDefault
                        guard let token = loginData.token else { return }
                        print(token)
                        UserDefaults.standard.saveUserToken(token: token)
                        UserDefaults.standard.setIsLoggedIn(value: true)
                        UserDefaults.standard.synchronize()
                        
                        self.isRegistered = true
                        self.isLoading = false
                    case .failure(let error):
                        self.isRegisterError = true
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                    }
                }
            // MARK:- Register Failure
            case .failure(let error):
                self.isRegisterError = true
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

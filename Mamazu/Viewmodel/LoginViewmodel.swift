//
//  LoginViewmodel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 25.02.2021.
//

import Foundation
import SwiftUI


class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isLoginError: Bool = false
    @Published var isLoggedIn: Bool = false
    
    @Published var isLoading: Bool = false
    @State private var showingAlert = false
    
    private var loginService = LoginService()
    
    func loginUser() {
        self.isLoading = true
        loginService.loginUser(email: email, password: password) { (result) in
            switch result {
            case .success(let loginData):
                //Save user token to userDefault
                guard let token = loginData.token else { return }
                print(token)
                UserDefaults.standard.saveUserToken(token: token)
                UserDefaults.standard.setIsLoggedIn(value: true)
                UserDefaults.standard.synchronize()
                
                self.isLoggedIn = true
                self.isLoading = false
                print(self.isLoggedIn)
            case .failure(let error):
                self.isLoginError = true
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

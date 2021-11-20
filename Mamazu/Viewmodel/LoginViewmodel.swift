//
//  LoginViewmodel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 25.02.2021.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    @Published var isLoginError: Bool = false
    @Published var isLoggedIn: Bool = false
    
    @Published var isLoading: Bool = false
    @State private var showingAlert = false
    
    private var loginService = LoginService()
    private var cancellables = Set<AnyCancellable>()
    
    func login() {
        self.isLoading = true
        loginService.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.showAlertMessage(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (result) in
                print(result)
                if result.error{
                    self?.showAlertMessage(result.message ?? "Login Error")
                }
                guard let token = result.token else { return }
                UserDefaults.standard.saveUserToken(token: token)
                self?.isLoggedIn = true
                self?.isLoading = false
            }).store(in: &cancellables)
    }
    
    fileprivate func showAlertMessage(_ message: String) {
        self.isLoading = false
        self.isLoginError = true
        self.errorMessage = message
    }
}

//
//  RegisterViewModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import UIKit
import SwiftUI
import Combine

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
    
    private var cancellables = Set<AnyCancellable>()
    
    func register() {
        self.isLoading = true
        registerService.register(name: name, email: email, password: password, profileImg: image)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.showAlertMessage(error.localizedDescription)
                }
            } receiveValue: { [unowned self] registeredUser in
                if !registeredUser.error {
                    loginService.login(email: email, password: password)
                        .sink(receiveCompletion: { completion in
                            print(completion)
                            if case let .failure(error) = completion {
                                self.showAlertMessage(error.localizedDescription)
                            }
                        }, receiveValue: { [weak self] (result) in
                            print(result)
                            if result.error{
                                self?.showAlertMessage(result.message ?? "Register Error")
                            }
                            guard let token = result.token else { return }
                            UserDefaults.standard.saveUserToken(token: token)
                            print(token)
                            self?.isRegistered = true
                            self?.isLoading = false
                        }).store(in: &cancellables)
                }
            }.store(in: &cancellables)
    }
    
    fileprivate func showAlertMessage(_ message: String) {
        self.isLoading = false
        self.isRegisterError = true
        self.errorMessage = message
    }
}

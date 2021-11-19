//
//  LoginService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 28.02.2021.
//

import SwiftUI
import Alamofire
import Combine

struct LoginService {
    
    
    func login(email: String, password: String) -> AnyPublisher<LoginModel, APIError> {
        if email.isEmpty == true || password.isEmpty == true{
            return Fail(error: APIError.errorWithMessage(LocalizedString.Errors.emailAndPasswordBlank)).eraseToAnyPublisher()
        }else if email.isValidEmail() == false {
            return Fail(error: APIError.errorWithMessage(LocalizedString.Errors.invalidEmail)).eraseToAnyPublisher()
        }
        
        let parameters = ["email": email, "password": password]
        var request = URLRequest(url: URL(string: LOGIN_URL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.unknown }
                
                if httpResponse.statusCode == 404 { throw APIError.errorWithMessage(LocalizedString.Errors.noUser) }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
               
                let decoder = JSONDecoder()
                return try decoder.decode(LoginModel.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.errorWithMessage(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  LoginService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 28.02.2021.
//

import SwiftUI
import Alamofire

struct LoginService {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginModel, APIError>) -> ()) {
        if email.isEmpty == true || password.isEmpty == true{
            completion(.failure(.errorWithMessage(LocalizedString.Errors.emailAndPasswordBlank)))
            return
        }else if email.isValidEmail() == false {
            completion(.failure(.errorWithMessage(LocalizedString.Errors.invalidEmail)))
            return
        }
        
        let parameters = ["email": email, "password": password]
        AF.request(LOGIN_URL, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                print(json)
                guard let data = response.data else { return completion(.failure(.decodingError)) }
                guard let json = try? JSONDecoder().decode(LoginModel.self, from: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                if json.error == true {
                    completion(.failure(.errorWithMessage(json.message ?? LocalizedString.Errors.somethingWentWrong)))
                }
                //Login Success
                completion(.success(json))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.errorWithMessage(error.localizedDescription)))
            }
        }
    }
}

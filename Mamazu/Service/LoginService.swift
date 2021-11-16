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
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                          throw APIError.unknown
                      }
                
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

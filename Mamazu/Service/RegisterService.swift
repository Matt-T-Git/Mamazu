//
//  RegisterService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import UIKit
import Alamofire
import Combine

struct RegisterService {
    
    func register(name: String, email: String, password: String, profileImg: UIImage)  -> AnyPublisher<RegisteModel, APIError>  {
        
        if name.isEmpty == true || email.isEmpty == true || password.isEmpty == true{
            return Fail(error: APIError.errorWithMessage(LocalizedString.Errors.emailAndPasswordBlank)).eraseToAnyPublisher()
        }else if email.isValidEmail() == false {
            return Fail(error: APIError.errorWithMessage(LocalizedString.Errors.invalidEmail)).eraseToAnyPublisher()
        }
        if profileImg.size == .zero {
            return Fail(error: APIError.errorWithMessage(LocalizedString.Errors.noImage)).eraseToAnyPublisher()
        }
     
        //Parameters
        let parameters: Dictionary<String, Any> = ["name": name,"email": email, "password": password]
        
        let mamazuRequest = MamazuMultipartImage(REGISTER_URL, paramters: parameters, image: profileImg, imagekey: "profileImg", imageName: "mamazu.jpeg")
        
        return URLSession.shared.dataTaskPublisher(for: mamazuRequest.request)
            .tryMap({ result in
                
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.unknown }
                
                if httpResponse.statusCode == 409 { throw APIError.errorWithMessage(LocalizedString.Errors.userIsExist) }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
                
                let decoder = JSONDecoder()
                return try decoder.decode(RegisteModel.self, from: result.data)
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


//
//  RegisterService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import UIKit
import Alamofire

struct RegisterService {
    func registerUser(name: String, email: String, password: String, profileImg: UIImage, completion: @escaping (Result<RegisteModel, APIError>) -> ()) {
        if name.isEmpty == true || email.isEmpty == true || password.isEmpty == true{
            completion(.failure(.errorWithMessage(LocalizedString.Errors.emailAndPasswordBlank)))
            return
        }else if email.isValidEmail() == false {
            completion(.failure(.errorWithMessage(LocalizedString.Errors.invalidEmail)))
            return
        }
        if profileImg.size == .zero {
            completion(.failure(.errorWithMessage(LocalizedString.Errors.noImage)))
            return
        }
        //Parameters
        let parameters = ["name": name,"email": email, "password": password]
        //ImageData Settings
        guard let imgData = profileImg.jpegData(compressionQuality: 0.5) else { return }
        
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Type": "application/json"]
        
        AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(imgData, withName: "profileImg", fileName: "image.jpg", mimeType: "image/jpg")
        }, to: REGISTER_URL, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseString(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                guard let data = resut else { return completion(.failure(.decodingError)) }
                guard let json = try? JSONDecoder().decode(RegisteModel.self, from: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                if json.error == true {
                    completion(.failure(.errorWithMessage(json.message ?? LocalizedString.Errors.somethingWentWrong)))
                    return
                }
                completion(.success(json))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.errorWithMessage(error.localizedDescription)))
                print("upload err: \(error)")
            }
        }
    }
}

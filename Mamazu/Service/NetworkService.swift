//
//  NetworkService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import Foundation
import Alamofire
import UIKit

struct NetworkService {
    
    var header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": UserDefaults.standard.returnUserToken()
    ]
    
    typealias params = Dictionary<String, Any>
    
    func fetchData<T: Codable>(urlString: String, completion: @escaping (Result<T, APIError>) -> ()){
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            switch response.result{
            case .success(_):
                guard let jsonData = response.data else { return }
                guard let items = try? JSONDecoder().decode(T.self, from: jsonData) else { return }
                completion(.success(items))
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(.errorWithMessage(err.localizedDescription)))
            }
        }
    }
    
    func fetchDataWithParameters<T: Decodable>(params: params, urlString: String, completion: @escaping (Result<T, APIError>) -> Void){
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success(_):
                    guard let jsonData = response.data else { return }
                    guard let items = try? JSONDecoder().decode(T.self, from: jsonData) else { return }
                    completion(.success(items))
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.failure(.errorWithMessage(err.localizedDescription)))
                }
            }
    }
    
    mutating func addNewLocation<T: Decodable>(image: UIImage,
                        title: String,
                        description: String,
                        latitude: Double, longitude: Double,
                        completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        header["Content-type"] = "multipart/form-data"
        let parameters: params = [
            "title": title,
            "description": description,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
        }, to: ADD_POST, method: .post, headers: header) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseString(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                guard let data = resut else { return completion(.failure(.decodingError)) }
                guard let json = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.decodingError))
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
    
    mutating func addLostPetLocation<T: Decodable>(image: UIImage,
                                                      petName: String,
                                                      petBreed: String,
                                                      petGender: String,
                                                      petAge: String,
                                                      description: String,
                                                      latitude: Double, longitude: Double,
                        completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        header["Content-type"] = "multipart/form-data"
        let parameters: params = [
            "petName": petName,
            "petBreed": petBreed,
            "petGender": petGender,
            "petAge": petAge,
            "description": description,
            "latitude": latitude,
            "longitude": longitude,
        ]
        
        AF.upload(multipartFormData: { multiPart in
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
        }, to: ADD_LOST_ANIMAL, method: .post, headers: header) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseString(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result {
            case .success(let resut):
                guard let data = resut else { return completion(.failure(.decodingError)) }
                guard let json = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.decodingError))
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
    
    func setFound(postId: String, completion: @escaping (Bool)->()) {
        let parameters: params = ["postId": postId]
        print(parameters)
        AF.request(FOUND_URL + postId, method: .patch, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                guard let JSON = json as? [String: Any] else { return }
                if let success = JSON["success"] as? Bool{
                    if success{
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
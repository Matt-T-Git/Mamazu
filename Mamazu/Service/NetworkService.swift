//
//  NetworkService.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//
import UIKit
import Combine

struct NetworkService {
    
    typealias params = Dictionary<String, Any>
    
    //MARK: - Fetch Data
    
    func fetchCombineData<T: Decodable>(urlString: String) -> AnyPublisher<T, APIError>  {
        guard let url = URL(string: urlString) else { fatalError() }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError { return error }
                else { return APIError.errorWithMessage(error.localizedDescription) }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchCombineDataWithParameters<T: Decodable>(params: params, urlString: String) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: urlString) else { fatalError("Url Error") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.unknown }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
                
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError { return error }
                else { return APIError.errorWithMessage(error.localizedDescription) }
            }
            .eraseToAnyPublisher()
    }
    
    func addLocation<T: Decodable>(_ url: String, parameters: params, image: UIImage) -> AnyPublisher<T, APIError> {
        let mamazuRequest = MamazuMultipartImage(url, paramters: parameters, image: image, imagekey: "image", imageName: "mamazu.jpeg")
        
        return URLSession.shared.dataTaskPublisher(for: mamazuRequest.request)
            .tryMap({ result in
                
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.unknown }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
                
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError { return error }
                else { return APIError.errorWithMessage(error.localizedDescription) }
            }
            .eraseToAnyPublisher()
    }
    
    func found(postId: String) -> AnyPublisher<Found, APIError> {
        
        guard let url = URL(string: FOUND_URL + postId) else { fatalError("URL Error") }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.decodingError }
                
                if httpResponse.statusCode == 404 { throw APIError.errorWithMessage(LocalizedString.Errors.noUser) }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
               
                let decoder = JSONDecoder()
                return try decoder.decode(Found.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError { return error }
                else { return APIError.errorWithMessage(error.localizedDescription) }
            }
            .eraseToAnyPublisher()
    }
    
    func deleteUser(userId: String) -> AnyPublisher<Found, APIError> {
        
        guard let url = URL(string: DELETE_USER_URL + userId) else { fatalError("URL Error") }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.returnUserToken(), forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                
                guard let httpResponse = result.response as? HTTPURLResponse else { throw APIError.decodingError }
                
                if httpResponse.statusCode == 404 { throw APIError.errorWithMessage(LocalizedString.Errors.noUser) }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw APIError.errorWithMessage("An error occurred. Error code is \(httpResponse.statusCode)") }
               
                let decoder = JSONDecoder()
                return try decoder.decode(Found.self, from: result.data)
            })
            .receive(on: RunLoop.main)
            .mapError { error in
                if let error = error as? APIError { return error }
                else { return APIError.errorWithMessage(error.localizedDescription) }
            }
            .eraseToAnyPublisher()
    }
}



//
//  CombineExtensions.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 13.11.2021.
//

import Foundation
import Combine

extension Publisher where Output == (data: Data, response: URLResponse) {
    func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), APIError> {
        tryMap { (data: Data, response: URLResponse) in
            guard let http = response as? HTTPURLResponse else { throw APIError.unknown }
            return (data, http)
        }
        .mapError { error in
            if error is APIError {
                return error as! APIError
            } else {
                return APIError.errorWithMessage(error.localizedDescription)
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where
    Output == (data: Data, response: HTTPURLResponse),
    Failure == APIError {
    
    func responseData() -> AnyPublisher<Data, APIError> {
        tryMap { (data: Data, response: HTTPURLResponse) -> Data in
            switch response.statusCode {
            case 200...299: return data
            case 400...499: throw APIError.unknown
            case 500...599: throw APIError.unknown
            default:
                throw APIError.errorWithMessage("Unhandled HTTP Response Status code: \(response.statusCode)")
            }
        }
        .mapError { $0 as! APIError }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Data, Failure == APIError {
    func decoding<T : Decodable, Decoder: TopLevelDecoder>(_ type: T.Type, decoder: Decoder) -> AnyPublisher<T, APIError> where Decoder.Input == Data {
        decode(type: T.self, decoder: decoder)
            .mapError { error in
                if error is DecodingError {
                    return APIError.decodingError
                } else {
                    return error as! APIError
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  LoginModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import Foundation


struct LoginModel: Codable {
    var error: Bool
    var message: String?
    var token: String?
}


enum APIError: Error {
    case decodingError
    case errorWithMessage(String)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from service"
        case .errorWithMessage(let message):
            return message
        case .unknown:
            return "The error is unknown"
        }
    }
}

//
//  Mamazu.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 17.03.2021.
//

import Foundation
import UIKit

struct Mamazu: Codable {
    let error: Bool
    var message: String?
    let results: [MamazuResults]
}

struct MamazuResults: Codable, Identifiable {
    
    let id: String
    let title: String
    let description: String
    let image: String
    let date: String
    let user: UserModel
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, description, image, date
        case user
        case location
    }
}

struct Location: Codable {
    let type: String
    let coordinates: [Double]
}

struct MamazuResult: Codable {
    let error: Bool
    var message: String?
    let results: MamazuResults?
}

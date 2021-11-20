//
//  LostModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 16.03.2021.
//

import Foundation

import Foundation

struct Lost: Codable {
    let error: Bool
    var message: String?
    let results: [LostAnimalResults]
}

struct LostAnimalResults: Codable, Identifiable {
    
    let id: String
    let description: String
    let image: String
    let petName: String
    let petAge: String
    let petGender: String
    let petBreed: String
    let date: String
    let isFound: Bool
    let user: UserModel
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description, image, petName, petAge, petGender, petBreed, date
        case isFound
        case user
        case location
    }
}
struct LostAnimalResult: Codable {
    let error: Bool
    var message: String?
}

struct Found: Codable {
    var success: Bool
}

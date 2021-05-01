//
//  UserModel.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 8.03.2021.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var profileImg: String
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, profileImg, token
    }
}

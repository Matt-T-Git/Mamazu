//
//  Constants.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 21.03.2019.
//  Copyright © 2019 Sercan Burak AĞIR. All rights reserved.
//

import Foundation

//let BASE_URL = "https://mamazu.herokuapp.com/"
let BASE_URL = "http://127.0.0.1:3000/"

let PROFILE_IMG_URL = ""
let MAMAZU_IMG_URL = ""
let LOST_ANIMAL_IMG_URL = ""

// MARK:- User
let LOGIN_URL = "\(BASE_URL)api/v1/user/login"
let REGISTER_URL = "\(BASE_URL)api/v1/user/register"
let CURRENT_USER_URL = "\(BASE_URL)api/v1/user/current"

//MARK:- Posts
let POSTS_URL = "\(BASE_URL)api/v1/posts/"
let CURRENT_USER_POSTS_URL = "\(BASE_URL)api/v1/posts/currentusersposts"
let ADD_POST = "\(BASE_URL)api/v1/posts/add"

//MARK:- Lost Animal
let LOST_LOCATION_URL = "\(BASE_URL)api/v1/lost/"
let CURRENT_USER_LOST_ANIMAL_URL = "\(BASE_URL)api/v1/lost/culostanimal"
let ADD_LOST_ANIMAL = "\(BASE_URL)api/v1/lost/add"
let FOUND_URL = "\(BASE_URL)api/v1/lost/found/"
let DELETE_USER_URL = "\(BASE_URL)api/v1/user/remove/"

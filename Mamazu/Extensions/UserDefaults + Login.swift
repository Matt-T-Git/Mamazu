//
//  UserDefaults + Login.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.03.2019.
//  Copyright © 2019 Sercan Burak AĞIR. All rights reserved.
//

import UIKit

extension UserDefaults{
    
    func setIsLoggedIn(value: Bool){
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
    
    func saveUserToken(token: String) {
        set(token, forKey: "userToken")
        synchronize()
    }
    
    func resetUserToken() {
        set("", forKey: "userToken")
        synchronize()
    }
    
    func returnUserToken() -> String {
        return string(forKey: "userToken") ?? ""
    }
}

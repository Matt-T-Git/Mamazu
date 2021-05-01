//
//  General.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 28.02.2021.
//

import Foundation
import SwiftUI
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
}

//Time Ago Func
public func timeAgoSince(_ date: Date) -> String {
    
    let calendar = Calendar.current
    let now = Date()
    let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
    let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
    
    if let year = components.year, year >= 2 {
        return "\(year) Yıl Önce Eklendi"
    }
    
    if let year = components.year, year >= 1 {
        return "Geçen Yıl Eklendi"
    }
    
    if let month = components.month, month >= 2 {
        return "\(month) Ay Önce Eklendi"
    }
    
    if let month = components.month, month >= 1 {
        return "Geçen Ay Eklendi"
    }
    
    if let week = components.weekOfYear, week >= 2 {
        return "\(week) Hafta Önce Eklendi"
    }
    
    if let week = components.weekOfYear, week >= 1 {
        return "Geçen Hafta Eklendi"
    }
    
    if let day = components.day, day >= 2 {
        return "\(day) Gün Önce Eklendi"
    }
    
    if let day = components.day, day >= 1 {
        return "Dün Eklendi"
    }
    
    if let hour = components.hour, hour >= 2 {
        return "\(hour) Saat Önce Eklendi"
    }
    
    if let hour = components.hour, hour >= 1 {
        return "1 Saat Önce Eklendi"
    }
    
    if let minute = components.minute, minute >= 2 {
        return "\(minute) Dakika Önce Eklendi"
    }
    
    if let minute = components.minute, minute >= 1 {
        return "Bir Dakika Önce Eklendi"
    }
    
    if let second = components.second, second >= 3 {
        return "\(second) Saniye Önce Eklendi"
    }
    
    return "Şimdi"
    
}

public func timeAgoFrom(_ dateString: String) -> String {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }
    
    guard let date = dateFormatter.date(from: dateString) else { return "Tarih Hatalı" }
    return timeAgoSince(date)
}

public func mamazuImgUrl(_ mamazuImgUrl: String) -> String {
    return MAMAZU_IMG_URL + mamazuImgUrl
}

public func profileImgUrl(_ profileImgUrl: String) -> String {
    return PROFILE_IMG_URL + profileImgUrl
}

public func lostAnimalImgUrl(_ lostImgUrl: String) -> String {
    return LOST_ANIMAL_IMG_URL + lostImgUrl
}

//Custom Rounded Corner.
struct RoundedShape : Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//Hide Keyboard.

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
//Usage
/*
 .onTapGesture {
       hideKeyboard()
     }
 */

extension Double {
    var formattedTime: String {
        var formattedTime = "0:00"
        if self > 0 {
            let hours = Int(self / 3600)
            let minutes = Int(truncatingRemainder(dividingBy: 3600) / 60)
            formattedTime = String(hours) + ":" + (minutes < 10 ? "0" + String(minutes) : String(minutes))
        }
        return formattedTime
    }
}

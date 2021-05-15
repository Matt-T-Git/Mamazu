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

func timeAgoSince(_ date: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named
    formatter.formattingContext = .beginningOfSentence
    return formatter.localizedString(for: date, relativeTo: Date())
}

public func timeAgoFrom(_ dateString: String) -> String {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }
    
    guard let date = dateFormatter.date(from: dateString) else { return LocalizedString.General.incorrectDate }
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

//
//  PreferenceKey.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 2.12.2021.
//

import SwiftUI

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

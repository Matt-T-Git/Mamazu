//
//  KeyboardHandler.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 3.03.2021.
//

import SwiftUI
import Combine

final class KeyboardHandler: ObservableObject {
    
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    private var cancallable: AnyCancellable?
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map {_ in CGFloat.zero }
    
    init() {
        cancallable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
    
}

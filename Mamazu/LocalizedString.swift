//
//  LocalizedString.swift
//  Mamazu
//
//  Created by Mathew Thomas on 08/05/2021.
//

import Foundation

struct LocalizedString {
    static let ok = NSLocalizedString("ok", comment: "")

    struct Login {
        static let welcomeBack = NSLocalizedString("login_welcome_back", comment: "")
        static let signInContinue = NSLocalizedString("login_sign_in_continue", comment: "")
        static let emailPlaceholder = NSLocalizedString("login_email_placeholder", comment: "")
        static let passwordPlaceholder = NSLocalizedString("login_password_placeholder", comment: "")
        static let loginString = NSLocalizedString("login_login_string", comment: "")
        static let notMember = NSLocalizedString("login_not_member_yet", comment: "")
        static let register = NSLocalizedString("login_register", comment: "")
    }

}

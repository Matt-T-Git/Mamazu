//
//  LocalizedString.swift
//  Mamazu
//
//  Created by Mathew Thomas on 08/05/2021.
//

import Foundation

struct LocalizedString {
    static let ok = NSLocalizedString("ok", comment: "")
    static let emailPlaceholder = NSLocalizedString("email_placeholder", comment: "")
    static let passwordPlaceholder = NSLocalizedString("password_placeholder", comment: "")
    static let loading = NSLocalizedString("loading", comment: "")

    struct Login {
        static let title = NSLocalizedString("login_title", comment: "")
        static let subtitle = NSLocalizedString("login_subtitle", comment: "")
        static let loginButtonTitle = NSLocalizedString("login_button_title", comment: "")
        static let notMember = NSLocalizedString("login_not_member_yet", comment: "")
        static let register = NSLocalizedString("login_register", comment: "")
    }

    struct Register {
        static let title = NSLocalizedString("register_title", comment: "")
        static let subtitle = NSLocalizedString("register_subtitle", comment: "")
        static let namePlaceholder = NSLocalizedString("register_name_placeholder", comment: "")
        static let registerButtonTitle = NSLocalizedString("register_button_title", comment: "")
        static let alreadyMember = NSLocalizedString("register_already_member", comment: "")
        static let login = NSLocalizedString("register_login", comment: "")
    }

}

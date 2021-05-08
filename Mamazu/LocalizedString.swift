//
//  LocalizedString.swift
//  Mamazu
//
//  Created by Mathew Thomas on 08/05/2021.
//

import Foundation

struct LocalizedString {
    static let ok = NSLocalizedString("ok", comment: "")
    static let add = NSLocalizedString("add", comment: "")
    static let profile = NSLocalizedString("profile", comment: "")
    static let settings = NSLocalizedString("settings", comment: "")
    static let emailPlaceholder = NSLocalizedString("email_placeholder", comment: "")
    static let passwordPlaceholder = NSLocalizedString("password_placeholder", comment: "")
    static let loading = NSLocalizedString("loading", comment: "")
    static let useCamera = NSLocalizedString("use_camera", comment: "")
    static let selectFromGallery = NSLocalizedString("select_from_gallery", comment: "")
    static let mapLocationChosen = NSLocalizedString("map_location_chosen", comment: "")
    static let locationDisabledMessage = NSLocalizedString("location_disabled_message", comment: "")
    static let welcome = NSLocalizedString("welcome", comment: "")
    static let minute = NSLocalizedString("minute", comment: "")
    static let hour = NSLocalizedString("hour", comment: "")

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

    struct AddLocation {
        static let lostPetDescriptionPlaceholder = NSLocalizedString("lost_pet_description_placeholder", comment: "")
        static let galleryDescription = NSLocalizedString("gallery_description", comment: "")
        static let animalNamePlaceholder = NSLocalizedString("animal_name_placeholder", comment: "")
        static let genderPlaceholder = NSLocalizedString("gender_placeholder", comment: "")
        static let agePlaceholder = NSLocalizedString("age_placeholder", comment: "")
        static let breedPlaceholder = NSLocalizedString("breed_placeholder", comment: "")
        static let saveLocationButtonTitle = NSLocalizedString("save_location_button_title", comment: "")
        static let selectLocation = NSLocalizedString("select_location", comment: "")
        static let locationSelected = NSLocalizedString("location_selected", comment: "")
        static let addHelpLocation = NSLocalizedString("add_help_location", comment: "")
        static let addMissingListing = NSLocalizedString("add_missing_listing", comment: "")
        static let addMamazuPlaceholder = NSLocalizedString("add_mamazu_placeholder", comment: "")
        static let locationPlaceholder  = NSLocalizedString("location_placeholder", comment: "")
    }

    struct Home {
        static let lostTitle = NSLocalizedString("home_lost_title", comment: "")
        static let noMissingReports = NSLocalizedString("home_no_missing_reports", comment: "")
        static let noHelpPoints = NSLocalizedString("home_no_help_points", comment: "")
        static let helpPoints = NSLocalizedString("home_help_points", comment: "")
        static let gender = NSLocalizedString("home_gender", comment: "")
        static let breed = NSLocalizedString("home_breed", comment: "")
        static let age = NSLocalizedString("home_age", comment: "")
        static let under1Year = NSLocalizedString("home_under_one_year", comment: "")
        static let yearsOfAge = NSLocalizedString("home_years_of_age", comment: "")
        static let found = NSLocalizedString("home_found", comment: "")
        static let areYouSureFound = NSLocalizedString("home_are_you_sure_found", comment: "")
        static let yesFound = NSLocalizedString("home_yes_found", comment: "")
    }

    struct Tutorial {
        static let title = NSLocalizedString("tutorial_title", comment: "")
    }

    struct Warning {
        static let mamazuString = NSLocalizedString("warning_mamazu", comment: "")
        static let lostString = NSLocalizedString("warning_lost", comment: "")
    }
}

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

    struct Profile {
        static let lost = NSLocalizedString("profile_lost", comment: "")
        static let areYouSureLogout = NSLocalizedString("profile_are_you_sure_logout", comment: "")
        static let logout = NSLocalizedString("profile_logout", comment: "")
        static let notSharedHelpPoints =  NSLocalizedString("profile_not_shared_help_points", comment: "")
        static let neverReportedLoss = NSLocalizedString("profile_never_reported_loss", comment: "")
        static let addNewEntry = NSLocalizedString("profile_add_new_entry", comment: "")
    }

    struct Tutorial {
        static let title = NSLocalizedString("tutorial_title", comment: "")
    }

    struct Errors {
        static let notificationSuccessfullySaved = NSLocalizedString("error_notification_save_success", comment: "")
        static let somethingWentWrongTryAgain = NSLocalizedString("error_something_went_wrong_try_again", comment: "")
        static let somethingWentWrong = NSLocalizedString("error_something_went_wrong", comment: "")
        static let emailAndPasswordBlank = NSLocalizedString("error_email_password_blank", comment: "")
        static let invalidEmail = NSLocalizedString("error_invalid_email", comment: "")
        static let noImage = NSLocalizedString("error_no_image", comment: "")
    }

    struct General {
        static let incorrectDate = NSLocalizedString("general_incorrect_date", comment: "")
        static let now = NSLocalizedString("general_now", comment: "")
        static let addedSecondsAgo = NSLocalizedString("general_added_seconds_ago", comment: "")
        static let addedAMinuteAgo = NSLocalizedString("general_added_a_minute_ago", comment: "")
        static let addedMinutesAgo = NSLocalizedString("general_added_minutes_ago", comment: "")
        static let addedOneHourAgo = NSLocalizedString("general_added_one_hour_ago", comment: "")
        static let addedHoursAgo = NSLocalizedString("general_added_hours_ago", comment: "")
        static let addedYesterday = NSLocalizedString("general_added_yesterday", comment: "")
        static let addedDaysAgo = NSLocalizedString("general_added_days_ago", comment: "")
        static let addedLastWeek = NSLocalizedString("general_added_last_week", comment: "")
        static let addedWeeksAgo = NSLocalizedString("general_added_weeks_ago", comment: "")
        static let addedLastMonth = NSLocalizedString("general_added_last_month", comment: "")
        static let addedMonthsAgo = NSLocalizedString("general_added_months_ago", comment: "")
        static let addedLastYear = NSLocalizedString("general_added_last_year", comment: "")
        static let addedYearsAgo = NSLocalizedString("general_added_years_ago", comment: "")
    }

    struct Warning {
        static let mamazuString = NSLocalizedString("warning_mamazu", comment: "")
        static let lostString = NSLocalizedString("warning_lost", comment: "")
    }
}

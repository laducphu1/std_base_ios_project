//
//  Constants.swift
//  BaseProject
//
//  Created by Fus on 15/05/2022.
//

import UIKit

struct K {
    struct App {
        static let AppStoreId = ""
        static let MinVersion = 0
    }

    struct CellIdentifier {

    }

    struct API {

    }

    struct Storyboard {
        struct Name {
            static let Main = "Main"
            static let Home = "Home"
        }
        struct SegueIdentifier {
            static let TermsAndConditions = "TermsAndConditionsSegueIdentifier"
            static let PrivacyPolicy = "PrivacyPolicySegueIdentifier"
        }
        struct VCIdentifier {
        }
    }

    struct Model {
        struct User {
            static let Name = ""
            struct Field {
                static let Identifier = "user_id"
                static let FirstName = "first_name"
                static let FullName = "full_name"
                static let Email = "email"
                static let Phone = "phone"
                static let LastName = "last_name"
                static let Code = "code"
                static let Dob = "dob"
                static let Nation = "nation"
            }
        }
    }

    struct UserDefaults {
    }

    struct Resource {

    }
    struct Font {
        static let Bold = ""
        static let SemiBold = ""
        static let Medium = ""
        static let Regular = ""
        static let Light = ""
    }
    struct Color {
        static let LuxorGold = #colorLiteral(red: 0.6666666667, green: 0.4745098039, blue: 0.2588235294, alpha: 1)
    }
    struct FontIcon {
        static let Ionicons = "Ionicons"
        static let Material = "Material"
    }
    struct Value {

    }

    struct Language {
        static let Vietnamese = "vi"
        static let Chinese = "zh-Hans"
        static let ChineseTraditional = "zh-Hant"
        static let English = "en"
        static let Japanese = "ja"
        static let Indonesian = "id-ID"
        static let German = "de"
        static let Russian = "ru-RU"
        static let Bulgarian = "bg"
    }

    struct SupportContact {
        static let Email = "support@abc.com"
        static let Phone = "+123456"
    }
}

struct Constants {
    struct Notificaton {
        static let UserDidLoggedIn = "kUserDidLoggedIn"
    }
}

struct AppRouter {
    struct Router {
        static let CharityRouter = "/charity/torque-gift"
    }

    struct RouterKey {
        static let OpenCharityView = "OpenCharityView"
    }
}

//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Stanislav Pavlenko on 01.05.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

struct Constants {
    static let appName = "⚡️FlashChat"
    static let registerSegue = "from_register_to_chat"
    static let loginSegue = "from_login_to_chat"
    static let cellNibName = "MessageCell"
    static let cellIdentifier = "ReusableCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

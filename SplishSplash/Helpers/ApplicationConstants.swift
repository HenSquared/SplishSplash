//
//  ApplicationConstants.swift
//  SplishSplash
//
//  Created by Henry Jones on 4/12/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import Foundation

enum UserMessages {
    static let promptOpen = "This will open in your default browser. Would you like to continue?"
}

enum AppConstants {
    static let appName = "SplishSplash"
    static let scheme = "https"
    static let host = "api.unsplash.com"
    static let photosPath = "/photos/"
    static let collectionsPath = "/collections/featured/"
    static let photosSearchPath = "/search/photos/"
    static let key = "781749348fb2f0266532ce4eeeccb9daaa0649169109a449c530ad736ae7223c"
    static let kAuthorizationParam = "client_id"
    static let kAccessKeyFieldName = "access_key"
    static let referralQueryItems = [URLQueryItem(name: "utm_source", value: AppConstants.appName), URLQueryItem(name: "medium", value: "referral")]
}

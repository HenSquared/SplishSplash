//
//  ApplicationConstants.swift
//  SplishSplash
//
//  Created by Henry Jones on 4/12/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import Foundation

enum AppConstants {
    static let appName = "SplishSplash"
    static let scheme = "https"
    static let host = "api.unsplash.com"
    static let photosPath = "/photos/"
    static let collectionsPath = "/collections/featured/"
    static let photosSearchPath = "/search/photos/"
    static let key = "7cb506e525ac5e7acd5c2994722f7a660712280212e694a7f9623f08cc357df8"
    static let kAuthorizationParam = "client_id"
    static let kAccessKeyFieldName = "access_key"
    static let referralQueryItems = [URLQueryItem(name: "utm_source", value: AppConstants.appName), URLQueryItem(name: "medium", value: "referral")]
}

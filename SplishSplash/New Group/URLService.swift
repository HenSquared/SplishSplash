//
//  URLService.swift
//  SplishSplash
//
//  Created by Henry Jones on 4/5/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import Foundation

/// URLService is used to build unsplash URLS
class URLService {
    /// Builds URLS for sharing unsplash links across the applicaiton. All Links that refer back to unsplash must include referral query params
    ///
    /// - Parameter url: the url to append the query to
    /// - Returns: new url with the query
    static func buildShareURL(url:URL) -> URL{
        let queryItems = AppConstants.referralQueryItems
        var urlComps = URLComponents(string: url.absoluteString)!
        urlComps.queryItems = queryItems
        let shareUrl = urlComps.url!
        return shareUrl
    }
}

//
//  ImageHelpers.swift
//  SplishSplash
//
//  Created by Henry Jones on 4/5/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import Foundation
import SDWebImage

struct downloadImageResponse : Codable {
    var url: String?
}

class ImageHelpers {
    /// Downloads an image from unsplash using the proper endpoint. Should be called from main thread.
    ///
    /// - Parameter splashItem: The Splash Item which contains the image.
    static func downloadUnsplashImage(splashItem: SplashItem) {
        DispatchQueue.global(qos: .background).async {
            guard let downloadURL = URL(string: splashItem.links.downloadLocation) else { return }
            var components = URLComponents.init(string: downloadURL.absoluteString)!
            let apiKeyQueryItem = URLQueryItem(name: "client_id", value: valueForAPIKey(named:"API_CLIENT_ID"))
            let decoder = JSONDecoder()
            components.queryItems = [apiKeyQueryItem]
            guard let data = try? Data(contentsOf: components.url!) else { return }
            if let response = try? decoder.decode(downloadImageResponse.self, from: data) {
                if let imageURL = response.url {
                    guard let imageResponseData = try? Data(contentsOf: URL(string: imageURL)!) else { return }
//                    if let image = UIImage(data: imageResponseData){
//                        CustomPhotoAlbum.sharedInstance.save(image: image)
//                    }
                }
            }
            
        }
    }
}

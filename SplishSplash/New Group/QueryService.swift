//
//  QueryService.swift
//  SplishSplash
//
//  Created by Henry Jones on 3/27/19.
//  Copyright © 2019 Henry Jones. All rights reserved.
//

import Foundation
import SDWebImage

class QueryService {
    
    func getSplashItemsFromCollectionIdentifier(collectionIdentifier: Int, pageNumber: Int, completionHandler: @escaping ([SplashItem]) -> Void) {
        var components = URLComponents()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = "/collections/\(collectionIdentifier)/photos/"
        
        components.queryItems = [URLQueryItem(name: "page", value: "\(pageNumber)"),
                                 URLQueryItem(name: "client_id", value: AppConstants.key)]
        guard let url = components.url else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    let splashItems = try decoder.decode([SplashItem].self, from: data!)
                    completionHandler(splashItems)
                }
                catch let jsonErr {
                    print("Failed to decode: ", jsonErr)
                }
            }
        }).resume()
    }
    
    
    func getImageDetails(splashItemId: String, completionHandler : @escaping (ImageDetails) -> Void) {
        var components = URLComponents()
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = AppConstants.photosPath
        components.path.append(splashItemId)
        components.queryItems = [URLQueryItem(name: "client_id", value: AppConstants.key)]
        guard let url = components.url
            else {return}
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if (error != nil){
                print("An error occured: \(error!)")
            } else {
                do {
                   let imageDetails = try decoder.decode(ImageDetails.self, from: data!)
                    completionHandler(imageDetails)
                }
                catch let jsonErr {
                    print("failed to decode: ", jsonErr)
                }
            }
        }).resume()
    }
    
    //Request new photos from unsplash
    func requestNewPhotos(perPage: Int = 15, pageNumber: Int = 0, completionHandler : @escaping ([SplashItem]) -> Void) {
        var splashItems = [SplashItem]()
        var components = URLComponents()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = AppConstants.photosPath
        components.queryItems =
            [URLQueryItem(name:"client_id", value: AppConstants.key),
             URLQueryItem(name: "page", value: "\(pageNumber)"),
             URLQueryItem(name: "per_page", value: "\(perPage)")]
        guard let url = components.url else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if (error != nil) {
                print(error!)
                return
            } else {
                do {
                    splashItems = try decoder.decode([SplashItem].self, from: data!)
                    completionHandler(splashItems)
                }
                catch let jsonErr {
                    print("Failed to decode: ", jsonErr)
                    return
                }
            }
        }).resume()
    }
    
    func requestNewCollections(perPage: Int = 15, pageNumber: Int = 0, completionHandler : @escaping ([SplashCollectionElement]) -> Void){
        _ = [SplashCollectionElement]()
        var components = URLComponents()
        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = AppConstants.collectionsPath
        components.queryItems =
            [URLQueryItem(name:"client_id", value: AppConstants.key),
             URLQueryItem(name: "page", value: "\(pageNumber)"),
             URLQueryItem(name: "per_page", value: "\(perPage)")]
        print(components.url!)
        guard let url = components.url else { return }
        print(url)
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if (error != nil) {
                print(error!)
                return
            } else {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let splashCollections = try decoder.decode([SplashCollectionElement].self, from: data!)
                    completionHandler(splashCollections)
                }
                catch let jsonErr {
                    print("Failed to decode: ", jsonErr)
                    return
                }
            }
        }).resume()
        
    }
    
    func requestNewPhotos(query: String, perPage: Int = 15, pageNumber: Int = 0, completionHandler : @escaping ([SplashItem]) -> Void) {
        var splashItems = [SplashItem]()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        var components = URLComponents()
        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = AppConstants.photosSearchPath
        components.queryItems =
            [URLQueryItem(name:"client_id", value: AppConstants.key),
             URLQueryItem(name: "page", value: "\(pageNumber)"),
             URLQueryItem(name: "per_page", value: "\(perPage)"),
             URLQueryItem(name: "query", value: query)]
        guard let url = components.url else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if (error != nil) {
                print(error!)
            } else {
                do {
                    let searchResponse = try? decoder.decode(SearchResponse.self, from: data!)
                    if searchResponse != nil{
                        for splashItem in (searchResponse?.results)!{
                            splashItems.append(splashItem)
                        }
                        completionHandler(splashItems)
                    }
                }
            }
        }).resume()
    }
}


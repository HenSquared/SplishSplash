import Foundation

struct SplashItem: Codable {
    let id: String
    let createdAt: Date
    let updatedAt: Date
    let width: Int
    let height: Int
    let color: String
    let description: String?
    let urls: Urls
    let links: SplashItemLinks
    let categories: [String]
    let sponsored: Bool
    let sponsoredBy: User?
    let sponsoredImpressionsid: String?
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let slug: String?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, createdAt = "created_at", updatedAt = "updated_at", width, height, color, description, urls, links, categories, sponsored, sponsoredBy = "sponsored_by", sponsoredImpressionsid = "sponsored_impressions_id", likes, likedByUser = "liked_by_user", currentUserCollections = "current_user_collections", slug, user
    }
}

struct SplashItemLinks: Codable {
    let linksSelf: String
    let html: String
    let download: String
    let downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self", html, download, downloadLocation = "download_location"
    }
}

struct Urls: Codable{
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct User: Codable {
    let id: String
    let updatedAt: Date
    let username: String
    let name: String
    let firstName: String
    let lastName: String?
    let twitterUsername: String?
    let portfoliourl: URL?
    let bio: String?
    let location: String?
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections: Int
    let totalLikes: Int
    let totalPhotos: Int
    let acceptedTos: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, updatedAt = "updated_at", username, name, firstName = "first_name", lastName = "last_name", twitterUsername = "twitter_username", portfoliourl = "portfolio_url", bio, location, links, profileImage = "profile_image", instagramUsername = "instagram_username", totalCollections = "total_collections", totalLikes = "total_likes", totalPhotos = "total_photos", acceptedTos = "accepted_tos"
    }
}


struct SearchResponse: Decodable {
    let total: Int?
    let totalPages: Int?
    let results: [SplashItem]?
}

struct UserLinks: Codable {
    let linksSelf: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    let following: String
    let followers: String
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self", html, photos, likes, portfolio, following, followers
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

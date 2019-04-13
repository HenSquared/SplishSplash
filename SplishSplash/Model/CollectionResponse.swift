import Foundation

typealias SplashCollection = [SplashCollectionElement]

struct SplashCollectionElement: Codable {
    let id: Int
    let title: String?
    let description: String?
    let publishedAt: Date?
    let updatedAt: Date?
    let curated: Bool?
    let featured: Bool?
    let totalPhotos: Int
    let splashCollectionPrivate: Bool?
    let shareKey: String?
    let tags: [Tag]?
    let coverPhoto: CoverPhoto?
    let previewPhotos: [PreviewPhoto]?
    let user: User
    let links: SplashCollectionLinks
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case curated = "curated"
        case featured = "featured"
        case totalPhotos = "total_photos"
        case splashCollectionPrivate = "private"
        case shareKey = "share_key"
        case tags = "tags"
        case coverPhoto = "cover_photo"
        case previewPhotos = "preview_photos"
        case user = "user"
        case links = "links"
    }
}

struct CoverPhoto: Codable {
    let id: String?
    let createdAt: Date?
    let updatedAt: Date?
    let width: Int?
    let height: Int?
    let color: String?
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: CoverPhotoLinks?
    let categories: [JSONAny]?
    let sponsored: Bool?
    let sponsoredBy: JSONNull?
    let sponsoredImpressionsid: JSONNull?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [JSONAny]?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case description = "description"
        case altDescription = "alt_description"
        case urls = "urls"
        case links = "links"
        case categories = "categories"
        case sponsored = "sponsored"
        case sponsoredBy = "sponsored_by"
        case sponsoredImpressionsid = "sponsored_impressions_id"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case user = "user"
    }
}

struct CoverPhotoLinks: Codable {
    let linksSelf: String?
    let html: String?
    let download: String?
    let downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html = "html"
        case download = "download"
        case downloadLocation = "download_location"
    }
}

struct SplashCollectionLinks: Codable {
    let linksSelf: String?
    let html: String?
    let photos: String?
    let related: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html = "html"
        case photos = "photos"
        case related = "related"
    }
}

struct PreviewPhoto: Codable {
    let id: String?
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case urls = "urls"
    }
}

struct Tag: Codable {
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}

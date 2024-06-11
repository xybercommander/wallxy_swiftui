import Foundation
import SwiftUI

// MARK: - ImageResponse
struct ImageResponse: Codable {
    var page, perPage: Int?
    var photos: [Photo]?
    var totalResults: Int?
    var nextPage: String?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

// MARK: - Photo
struct Photo: Codable, Identifiable, Hashable {
    var id, width, height: Int?
    var url: String?
    var photographer: String?
    var photographerURL: String?
    var photographerID: Int?
    var avgColor: String?
    var src: Src?
    var liked: Bool?
    var alt: String?

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src, liked, alt
    }

    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Conform to Equatable
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Src
struct Src: Codable, Hashable {
    var original, large2X, large, medium: String?
    var small, portrait, landscape, tiny: String?

    enum CodingKeys: String, CodingKey {
        case original
        case large2X = "large2x"
        case large, medium, small, portrait, landscape, tiny
    }

    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(original)
    }

    // Conform to Equatable
    static func == (lhs: Src, rhs: Src) -> Bool {
        return lhs.original == rhs.original
    }
}

//
//  TMDB.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/17.
//

import Foundation

struct RecommendationsContainer: Codable {
    let page: Int
    let results: [Recommendations]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Recommendations
struct Recommendations: Codable {
    let adult: Bool
    let backdropPath, posterPath: String?
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
    case zh = "zh"
}

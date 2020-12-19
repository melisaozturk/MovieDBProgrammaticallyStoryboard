//
//  PopularMovieModel.swift
//  MovieDBYemeksepeti
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

struct PopularMovieModel: Decodable {
    let page, totalResults, totalPages: Int
    let results: [PopularResult]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct PopularResult: Decodable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalTitle: String
    let genreIDS: [Int]
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

//
//  MovieDetailModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import Foundation

enum AdultTypeEnum: String {
    case Adult = "Adult"
    case AllAges = "AllAges"
}

struct MovieDetailModel: Decodable {
    var adult : Bool = false
    var backdropPath : String = ""
    var budget : Int = 0
    var genres : [Genre] = [Genre]()
    var homepage : String = ""
    var id : Int = 0
    var imdbId : String = ""
    var originalLanguage : String = ""
    var originalTitle : String = ""
    var overview : String = ""
    var popularity : Float = 0.0
    var posterPath : String = ""
    var productionCompanies : [ProductionCompany] = [ProductionCompany]()
    var productionCountries : [ProductionCountry] = [ProductionCountry]()
    var releaseDate : String = ""
    var revenue : Int = 0
    var runtime : Int = 0
    var spokenLanguages : [SpokenLanguage] = [SpokenLanguage]()
    var status : String = ""
    var tagline : String = ""
    var title : String = ""
    var video : Bool = false
    var voteAverage : Float = 0.0
    var voteCount : Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}

struct SpokenLanguage : Decodable {
    
    let englishName : String?
    let iso6391 : String?
    let name : String?
    
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name = "name"
    }
    
}

struct ProductionCompany : Decodable {
    
    let id : Int?
    let logoPath : String?
    let name : String?
    let originCountry : String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
    
}

struct ProductionCountry : Decodable {
    
    let iso31661 : String?
    let name : String?
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
}

struct Genre : Decodable {
    let id : Int?
    let name : String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }    
}

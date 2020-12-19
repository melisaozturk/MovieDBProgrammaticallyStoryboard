//
//  MovieCreditsModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 20.12.2020.
//

import Foundation

struct MovieCreditsModel: Decodable {
    let id: Int
    let cast, crew: [MovieCast]?
}

struct MovieCast: Decodable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: MovieDepartment
    let name, originalName: String?
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: MovieDepartment?
    let job: String?
    
    private enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

enum MovieDepartment: String, Decodable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

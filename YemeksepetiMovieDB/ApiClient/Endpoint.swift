//
//  Endpoint.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

enum Endpoint {
    case movie_popular
    case movie_detail(Int)
    case movie_credits(Int)}

extension Endpoint: BaseEndpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .movie_popular: return "/3/movie/popular"
        case .movie_detail(let id): return "/3/movie/\(id)"
        case .movie_credits(let id): return "/3/movie/\(id)/credits"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .movie_popular:
            return [URLQueryItem(name: "api_key", value:"45a4fdf097060d7804046ad3fe9098c3"), URLQueryItem(name: "language", value:"en-US"), URLQueryItem(name: "page", value: "1")]
        case .movie_detail, .movie_credits:
            return[URLQueryItem(name: "api_key", value:"45a4fdf097060d7804046ad3fe9098c3"), URLQueryItem(name: "language", value:"en-US")]
        }
    }
}

//
//  BaseEndpoint.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

protocol BaseEndpoint {
    var base: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}

extension BaseEndpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = query
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

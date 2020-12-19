//
//  MovieViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

class MovieViewModel: ApiClient {
    
    let session: URLSession
    var popularModel: PopularMovieModel!
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getPopularData(completion: @escaping (PopularMovieModel) -> Void, completionHandler: @escaping (String) -> Void) {
        
        let endpoint = Endpoint.movie_popular
        let request = endpoint.request
        #if DEBUG
        print(request)
        #endif
        
        fetch(with: request, decode: { json -> PopularMovieModel? in
            guard let feedResult = json as? PopularMovieModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let successResponse):
                self.popularModel = successResponse
                completion(successResponse)
            case .failure(_):
                #if DEBUG
                print("Data Fetch Failed")
                #endif
                completionHandler("Error")
            }
        })
        
    }
}

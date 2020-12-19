//
//  MovieDetailViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import Foundation

class MovieDetailViewModel: ApiClient, IViewModel {
    
    var session: URLSession
    
    var updateUIHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?
    
    var movieDetailModel: MovieDetailModel? {
        didSet {
            self.updateUIHandler?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusHandler?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertHandler?()
        }
    }
        
//    var movieCreditsModel: MovieCreditsModel!
        
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getMovieDetailData(id: Int) {
        
        let endpoint = Endpoint.movie_detail(id)
        let request = endpoint.request
        #if DEBUG
        print(request)
        #endif
        self.isLoading = true

        fetch(with: request, decode: { json -> MovieDetailModel? in
            guard let feedResult = json as? MovieDetailModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let successResponse):
                self.movieDetailModel = successResponse
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
    }
    
//    func getMovieCreditsData(id: Int, completion: @escaping (MovieCreditsModel) -> Void, completionHandler: @escaping (String) -> Void) {
//        
//        let endpoint = Endpoint.movie_credits(id)
//        let request = endpoint.request
//        #if DEBUG
//        print(request)
//        #endif
//        
//        fetch(with: request, decode: { json -> MovieCreditsModel? in
//            guard let feedResult = json as? MovieCreditsModel else { return  nil }
//            return feedResult
//        }, completion: { [weak self] response in
//            guard let self = self else { return }
//            
//            switch response {
//            case .success(let successResponse):
//                self.movieCreditsModel = successResponse
//                completion(successResponse)
//            case .failure(_):
//                #if DEBUG
//                print("Data Fetch Failed")
//                #endif
//                completionHandler("Error")
//            }
//        })
//    }
    
}

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
    
    var updateUIHandlerCredits: (()->())?
    
    var movieDetailModel: MovieDetailModel? {
        didSet {
            self.updateUIHandler?()
        }
    }

    var movieCreditsModel: MovieCreditsModel? {
        didSet {
            self.updateUIHandlerCredits?()
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
    
    func getMovieCreditsData(id: Int) {
        
        let endpoint = Endpoint.movie_credits(id)
        let request = endpoint.request
        #if DEBUG
        print(request)
        #endif
        
        self.isLoading = true
        fetch(with: request, decode: { json -> MovieCreditsModel? in
            guard let feedResult = json as? MovieCreditsModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let successResponse):
                self.movieCreditsModel = successResponse
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
    }
    
}

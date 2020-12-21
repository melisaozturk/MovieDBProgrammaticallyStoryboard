//
//  MovieDetailViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import Foundation

class MovieDetailViewModel: ApiClient, IViewModel {
    
    var session: URLSession?
        
    var updateUIHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?
    
    var updateUIHandlerCredits: (()->())?

    private var id: Int?
    
    var movieDetailModel: MovieDetailModel! {
        didSet {
            self.updateUIHandler?()
        }
    }

    var movieCreditsModel: [MovieCast] = [MovieCast]() {
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
    
    var numberOfCells: Int {
        return movieCreditsModel.count
    }
    
    init(configuration: URLSessionConfiguration, id: Int?) {
        self.session = URLSession(configuration: configuration)
        self.id = id
    }
    
//    convenience init() {
//        self.init(configuration: .default, id: 0)
//    }
    
    
    
    func getMovieDetailData() {
        
        let endpoint = Endpoint.movie_detail(self.id!)
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
            case .failure(_):
                self.alertMessage = "Movie detail was not found."
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
    }
    
    func getMovieCreditsData() {
        
        let endpoint = Endpoint.movie_credits(self.id!)
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
                self.movieCreditsModel = successResponse.cast!
            case .failure(_):
                self.alertMessage = "Cast data was not found."
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
    }
 
    func userPressedCast(at indexPath: IndexPath ){
        let cast = self.movieCreditsModel[indexPath.row]
        if cast.id != nil  {
            self.id = cast.id
        } else {
            self.id = nil
            self.alertMessage = "Cast detail was not found."
        }
    }
    
}

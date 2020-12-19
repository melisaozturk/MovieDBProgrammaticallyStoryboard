//
//  MovieViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

class MovieViewModel: ApiClient, IViewModel {    
    
    var session: URLSession
    
    var reloadTableViewHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?

    var cellModel: [PopularResult] = [PopularResult]() {
        didSet {
            self.reloadTableViewHandler?()
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
        return cellModel.count
    }
    
    var selectedMovie: PopularResult?
    var popularModel: PopularMovieModel!
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getPopularData() {
        
        let endpoint = Endpoint.movie_popular
        let request = endpoint.request
        #if DEBUG
        print(request)
        #endif
        
        self.isLoading = true
        fetch(with: request, decode: { json -> PopularMovieModel? in
            guard let feedResult = json as? PopularMovieModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let successResponse):
                self.popularModel = successResponse
                self.cellModel.append(contentsOf: successResponse.results)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
        
    }
    
    func getCellModel(at indexPath: IndexPath) -> [PopularResult] {
        return cellModel
    }
        
    func userPressed(at indexPath: IndexPath ){
        let movie = self.popularModel.results[indexPath.row]
        self.selectedMovie = movie
        
//        if photo.for_sale {
//            self.isAllowSegue = true
            
        
//        }
//        else {
//            self.isAllowSegue = false
//            self.selectedPhoto = nil
//            self.alertMessage = "Item detail was not found"
//        }
        
    }
    
}

//
//  MovieViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

class MovieViewModel: ApiClient, IViewModel {
        
    
    var session: URLSession
    
    var updateUIHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?
    
    var updateFilterStatus: (()->())?
    
    var movieID: Int?
    var filteredData = [MovieResult]()
    
    var movieModel: [MovieResult] = [MovieResult]() {
        didSet {
            self.updateUIHandler?()
        }
    }
 
    var filterModel: [MovieResult] = [MovieResult]() {
        didSet {
            self.updateUIHandler?()
        }
    }
    
    var isActive: Bool = false {
        didSet {
            self.updateFilterStatus?()
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
        if isActive {
            return filteredData.count
        }
        else {
            return movieModel.count
        }
    }
    
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
        fetch(with: request, decode: { json -> MovieModel? in
            guard let feedResult = json as? MovieModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let successResponse):
                self.movieModel.append(contentsOf: successResponse.results)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
        
    }
    
    func getSearchMovies(searchKey: String) {
     
        let endpoint = Endpoint.movie_search(searchKey)
        let request = endpoint.request
        #if DEBUG
        print(request)
        #endif
        
        self.isLoading = true
        fetch(with: request, decode: { json -> MovieModel? in
            guard let feedResult = json as?  MovieModel else { return  nil }
            return feedResult
        }, completion: { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let successResponse):
                self.filterModel.append(contentsOf: successResponse.results)
                self.filterData(searchKey: searchKey)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })                
    }
    
    func getCellModel(at indexPath: IndexPath) -> [MovieResult] {
        return movieModel
    }
        
    func userPressed(at indexPath: IndexPath ){
        let movie = self.movieModel[indexPath.row]
        
        if movie.id != nil  {
            self.movieID = movie.id
        } else {
            self.movieID = nil
            self.alertMessage = "Item detail was not found"
        }
    }
    
    private func filterData(searchKey: String) {
        self.filteredData = self.filterModel.filter({(model: MovieResult) -> Bool in
            return (model.title!.lowercased().contains(searchKey.lowercased()))
        })
        
        if self.filteredData.count == 0 {
            self.isActive = false
        }
        else {
            self.isActive = true
        }
    }
}

//
//  MovieViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation

class MovieViewModel: ApiClient, IViewModel {
    
    var updateUIHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?
    
    var updateFilterStatus: (()->())?
    
    var id: Int?
    
    var filteredData: [MovieResult] = [MovieResult]() {
        didSet {
            self.updateUIHandler?()
        }
    }
    
    var movieModel: [MovieResult] = [MovieResult]() {
        didSet {
            self.updateUIHandler?()
        }
    }
    
    var isActive: Bool = false {
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
    
    var numberOfCells: Int {
        if isActive {
            return filteredData.count
        }
        else {
            return movieModel.count
        }
    }
    
    var returnData: [MovieResult] {
        if isActive {
            return filteredData
        }
        else {
            return movieModel
        }
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
            case .failure(_):
                self.alertMessage = "Movie data was not found."
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
        
    }
    
    func getSearchMovies(searchKey: String) {             
        if !searchKey.isEmpty {
            self.isActive = true
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
                    self.movieModel.append(contentsOf: successResponse.results)
                    self.filterData(searchKey: searchKey)
                case .failure(_):
                    self.alertMessage = "Search data was not found."
                    #if DEBUG
                    print("Data Fetch Failed")
                    #endif
                }
            })
        } else {
            self.isActive = false
        }
    }
    
    func getCellModel(at indexPath: IndexPath) -> [MovieResult] {
        return movieModel
    }
    
    func userPressed(at indexPath: IndexPath ){
              
        if self.isActive {
            let filteredMovie = self.filteredData[indexPath.row]
            if filteredMovie.id != nil  {
                self.id = filteredMovie.id
            } else {
                self.id = nil
                self.alertMessage = "Movie detail was not found"
            }
        } else {
            let movie = self.movieModel[indexPath.row]
            if movie.id != nil  {
                self.id = movie.id
            } else {
                self.id = nil
                self.alertMessage = "Movie detail was not found"
            }
        }
    }
    
    private func filterData(searchKey: String) {
        self.filteredData = self.movieModel.filter({(model: MovieResult) -> Bool in
            return (model.title!.lowercased().contains(searchKey.lowercased()))
        })
        
        if self.filteredData.isEmpty {
            self.isActive = false
        }
        else {
            self.isActive = true
        }
    }
    
}

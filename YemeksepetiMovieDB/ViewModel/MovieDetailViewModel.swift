//
//  MovieDetailViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import Foundation

struct LabelModel {
    var text : String?
    var value : String?
}

class MovieDetailViewModel: ApiClient, IViewModel {
    
    var updateUIHandler: (()->())?
    var showAlertHandler: (()->())?
    var updateLoadingStatusHandler: (()->())?
    
    var updateUIHandlerCredits: (()->())?
    
    var id: Int?
    
    var movieDetailModel: MovieDetailModel! {
        didSet {
            labelModel = list
        }
    }

    var labelModel: [LabelModel] = [LabelModel]() {
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
    
    var numberOfCastCells: Int {
        return movieCreditsModel.count
    }
    
    var numberOfDetailCells: Int {
        return list.count
    }
    
    lazy var list: [LabelModel] = {
        var list = [LabelModel]()
        var itemString: String = ""
        
        if self.movieDetailModel != nil {//TODO SİL
            if !self.movieDetailModel.title.isEmpty {
                list[0].text = "Title: "
                list[0].value = self.movieDetailModel.title
            }
            
            if !self.movieDetailModel.originalTitle.isEmpty {
                list[1].text = "Original Title: "
                list[1].value = self.movieDetailModel.originalTitle
            }
            
            list[2].text = "Movie For: "
            list[2].value = self.movieDetailModel!.adult ? AdultTypeEnum.Adult.rawValue : AdultTypeEnum.AllAges.rawValue
            
            if !self.movieDetailModel.status.isEmpty {
                list[3].text = "Status: "
                list[3].value = self.movieDetailModel.status
            }
            
            if self.movieDetailModel.runtime == 0 {
                list[4].text = "Runtime: "
                list[4].value = "\(self.movieDetailModel.runtime) dk"
            }
            
            if self.movieDetailModel.popularity == 0.0 {
                list[5].text = "Popularity: "
                list[5].value = String(self.movieDetailModel.popularity)
            }
            
            if self.movieDetailModel.voteCount == 0 {
                list[6].text = "Vote Count: "
                list[6].value = String(self.movieDetailModel.voteCount)
            }
            
            if self.movieDetailModel.voteAverage == 0 {
                list[7].text = "Vote Average: "
                list[7].value = String(self.movieDetailModel.voteAverage)
            }
            
            if !self.movieDetailModel.originalLanguage.isEmpty {
                list[8].text = "Original Language: "
                list[8].value = String(self.movieDetailModel.originalLanguage)
            }
            
            if !self.movieDetailModel.releaseDate.isEmpty {
                list[9].text = "Release Date: "
                list[9].value = String(self.movieDetailModel.releaseDate)
            }
            
            if !self.movieDetailModel.overview.isEmpty {
                list[10].text = "Overview: "
                list[10].value = String(self.movieDetailModel.overview)
            }
            
            if !self.movieDetailModel.genres.isEmpty {
                //                itemString.removeAll()
                for (index, item) in self.movieDetailModel.genres.enumerated() {
                    itemString.append(item.name!)
                    if index < self.movieDetailModel.genres.count - 1 {
                        itemString.append("-")
                    }
                }
                list[11].text = "Genre: "
                list[11].value = itemString
            }
            
            if !self.movieDetailModel!.spokenLanguages.isEmpty {
                //            itemString.removeAll()
                for (index, item) in self.movieDetailModel!.spokenLanguages.enumerated()
                {
                    itemString.append(item.name!)
                    if index < self.movieDetailModel!.spokenLanguages.count - 1{
                        itemString.append("-")
                    }
                }
                list[12].text = "Spoken Languages: "
                list[12].value = itemString
            }
            
            if !self.movieDetailModel!.productionCompanies.isEmpty {
                //            itemString.removeAll()
                for (index, item) in self.movieDetailModel!.productionCompanies.enumerated() {
                    itemString.append(item.name!)
                    if index < self.movieDetailModel!.productionCompanies.count - 1{
                        itemString.append("-")
                    }
                }
                list[13].text = "Production Companies: "
                list[13].value = itemString
            }
            
            if !self.movieDetailModel!.productionCountries.isEmpty {
                itemString.removeAll()
                for (index, item) in self.movieDetailModel!.productionCountries.enumerated() {
                    itemString.append(item.name!)
                    if index < self.movieDetailModel!.productionCountries.count - 1 {
                        itemString.append("-")
                    }
                }
                list[14].text = "Production Countries: "
                list[14].value = itemString
            }
            
//            if !self.movieDetailModel.posterPath.isEmpty {
//                list[15].text = ""
//                list[15].value = "http://image.tmdb.org/t/p/w500//\(self.movieDetailModel.posterPath)"
//            }
        }
        return list
    }()
    
    init() { }
    
    init(id: Int) {
        self.id = id
    }
    
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

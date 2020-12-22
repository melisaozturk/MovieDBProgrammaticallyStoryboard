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
        return labelModel.count
    }
        
    var returnData: [LabelModel] {
       return labelModel
    }
   
    var returnCastData: [MovieCast]  {
       return movieCreditsModel
    }
           
    lazy var list: [LabelModel] = {
        var list = LabelModel()
        var listArray = [LabelModel]()
        var itemString: String = ""
        
        if !self.movieDetailModel.title.isEmpty {
            list.text = "Title: "
            list.value = self.movieDetailModel.title
            listArray.append(list)
        }
        
        if !self.movieDetailModel.originalTitle.isEmpty {
            list.text = "Original Title: "
            list.value = self.movieDetailModel.originalTitle
            listArray.append(list)
        }
        
        list.text = "Movie For: "
        list.value = self.movieDetailModel!.adult ? AdultTypeEnum.Adult.rawValue : AdultTypeEnum.AllAges.rawValue
        listArray.append(list)
        
        if !self.movieDetailModel.status.isEmpty {
            list.text = "Status: "
            list.value = self.movieDetailModel.status
            listArray.append(list)
        }
        
        if self.movieDetailModel.runtime == 0 {
            list.text = "Runtime: "
            list.value = "\(self.movieDetailModel.runtime) dk"
            listArray.append(list)
        }
        
        if self.movieDetailModel.popularity == 0.0 {
            list.text = "Popularity: "
            list.value = String(self.movieDetailModel.popularity)
            listArray.append(list)
        }
        
        if self.movieDetailModel.voteCount == 0 {
            list.text = "Vote Count: "
            list.value = String(self.movieDetailModel.voteCount)
            listArray.append(list)
        }
        
        if self.movieDetailModel.voteAverage == 0 {
            list.text = "Vote Average: "
            list.value = String(self.movieDetailModel.voteAverage)
            listArray.append(list)
        }
        
        if !self.movieDetailModel.originalLanguage.isEmpty {
            list.text = "Original Language: "
            list.value = String(self.movieDetailModel.originalLanguage)
            listArray.append(list)
        }
        
        if !self.movieDetailModel.releaseDate.isEmpty {
            list.text = "Release Date: "
            list.value = String(self.movieDetailModel.releaseDate)
            listArray.append(list)
        }

        if !self.movieDetailModel.genres.isEmpty {
                            itemString.removeAll()
            for (index, item) in self.movieDetailModel.genres.enumerated() {
                itemString.append(item.name!)
                if index < self.movieDetailModel.genres.count - 1 {
                    itemString.append("-")
                }
            }
            list.text = "Genre: "
            list.value = itemString
            listArray.append(list)
        }
        
        if !self.movieDetailModel!.spokenLanguages.isEmpty {
                        itemString.removeAll()
            for (index, item) in self.movieDetailModel!.spokenLanguages.enumerated()
            {
                itemString.append(item.name!)
                if index < self.movieDetailModel!.spokenLanguages.count - 1{
                    itemString.append("-")
                }
            }
            list.text = "Spoken Languages: "
            list.value = itemString
            listArray.append(list)
        }

        if !self.movieDetailModel!.productionCompanies.isEmpty {
                        itemString.removeAll()
            for (index, item) in self.movieDetailModel!.productionCompanies.enumerated() {
                itemString.append(item.name!)
                if index < self.movieDetailModel!.productionCompanies.count - 1{
                    itemString.append("-")
                }
            }
            list.text = "Production Companies: "
            list.value = itemString
            listArray.append(list)
        }
        
        if !self.movieDetailModel!.productionCountries.isEmpty {
            itemString.removeAll()
            for (index, item) in self.movieDetailModel!.productionCountries.enumerated() {
                itemString.append(item.name!)
                if index < self.movieDetailModel!.productionCountries.count - 1 {
                    itemString.append("-")
                }
            }
            list.text = "Production Countries: "
            list.value = itemString
            listArray.append(list)
        }
        if !self.movieDetailModel.overview.isEmpty {
            list.text = "Overview: "
            list.value = String(self.movieDetailModel.overview)
            listArray.append(list)
        }
        
        return listArray
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
                self.labelModel = self.list
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
                #if DEBUG
                print("Data Fetch Failed")
                #endif
            }
        })
    }
    
    func userPressedCast(at indexPath: IndexPath) {
        let cast = self.movieCreditsModel[indexPath.row]
        if cast.id != nil  {
            self.id = cast.id
        } else {
            self.id = nil
            self.alertMessage = "Cast detail was not found."
        }
    }
    
    
}

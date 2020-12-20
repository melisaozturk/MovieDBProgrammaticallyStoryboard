//
//  DetailViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private var imageViewMovie = UIImageView()
    private var labelTitle = UILabel()
    private var labelOriginalTitle = UILabel()
    private var labelAdult = UILabel()
    private var labelGenre = UILabel()
    private var labelOriginalLanguage = UILabel()
    private var labelSpokenLanguages = UILabel()
    private var labelReleaseDate = UILabel()
    private var labelPopularity = UILabel()
    private var labelRuntime = UILabel()
    private var labelStatus = UILabel()
    private var labelVoteAverage = UILabel()
    private var labelVoteCount = UILabel()
    private var labelProductionCompanies = UILabel()
    private var labelProductionCountries = UILabel()
    private var textViewOverView = UITextView()
    
    var movieID: Int?
    
    lazy var stackViewContainer: UIStackView = {
        var stackViewContainer = UIStackView()
        stackViewContainer.axis = .vertical
        stackViewContainer.alignment = .leading
        stackViewContainer.distribution = .equalSpacing
        stackViewContainer.spacing = 10
        stackViewContainer.contentMode = .scaleToFill
        return stackViewContainer
    }()
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()
    
    lazy var contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 250)
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        scroll.backgroundColor = .white
        return scroll
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        configureConstraints()
        configureCollectionView()
        updateUI()
    }
    
    private func configureController() {
        self.view.backgroundColor = .white
        
        labelTitle.numberOfLines = 0
        labelOriginalTitle.numberOfLines = 0
        labelProductionCompanies.numberOfLines = 0
        labelProductionCountries.numberOfLines = 0
        
        scrollView.bounces = false
        
        textViewOverView.isEditable = false
        textViewOverView.isScrollEnabled = false
        textViewOverView.isSelectable = false
        textViewOverView.textAlignment = .left
        textViewOverView.font = UIFont(name: ".SFUI-Regular", size: 17)
    }
    
    private func configureCollectionView() {
        
    }
    
    private func configureConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(imageViewMovie)
        
        imageViewMovie.translatesAutoresizingMaskIntoConstraints = false
        imageViewMovie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        imageViewMovie.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imageViewMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageViewMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        containerView.addSubview(stackViewContainer)
        
        stackViewContainer.addArrangedSubview(labelTitle)
        stackViewContainer.addArrangedSubview(labelOriginalTitle)
        stackViewContainer.addArrangedSubview(labelRuntime)
        stackViewContainer.addArrangedSubview(labelPopularity)
        stackViewContainer.addArrangedSubview(labelStatus)
        stackViewContainer.addArrangedSubview(labelGenre)
        stackViewContainer.addArrangedSubview(labelOriginalLanguage)
        stackViewContainer.addArrangedSubview(labelReleaseDate)
        stackViewContainer.addArrangedSubview(labelSpokenLanguages)
        stackViewContainer.addArrangedSubview(labelAdult)
        stackViewContainer.addArrangedSubview(labelVoteAverage)
        stackViewContainer.addArrangedSubview(labelVoteCount)
        stackViewContainer.addArrangedSubview(labelProductionCompanies)
        stackViewContainer.addArrangedSubview(labelProductionCountries)
        stackViewContainer.addArrangedSubview(textViewOverView)

        
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 20).isActive = true
        stackViewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        stackViewContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
                
    }
    
    private func updateUI() {
        
        viewModel.showAlertHandler = { [weak self] in
            guard let self = self else { return }
            if let message = self.viewModel.alertMessage {
                UIUtil.shared().showMessage(viewController: self, message: message)
            }
        }
        
        viewModel.updateLoadingStatusHandler = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let isLoading = self.viewModel.isLoading
                if isLoading {
                    UIUtil.shared().showLoading(view: self.view)
                }else {
                    UIUtil.shared().removeLoading(view: self.view)
                }
            }
        }
        
        viewModel.updateUIHandler = { [weak self] in
            guard let self = self else { return }
            let url = URL(string: "http://image.tmdb.org/t/p/w500//\(self.viewModel.movieDetailModel!.posterPath ?? "")")
            self.imageViewMovie.kf.setImage(with: url)
            self.labelTitle.text = self.viewModel.movieDetailModel!.title != nil ? "Title: \(self.viewModel.movieDetailModel!.title!)" : ""
            self.labelOriginalTitle.text = self.viewModel.movieDetailModel!.title != nil ? "Original Title: \(self.viewModel.movieDetailModel!.title!)" : ""
            self.labelAdult.text = self.viewModel.movieDetailModel!.adult != nil ? "MovieFor: \((self.viewModel.movieDetailModel!.adult!) ? AdultTypeEnum.Adult.rawValue : AdultTypeEnum.AllAges.rawValue)" : ""
            self.labelStatus.text = self.viewModel.movieDetailModel!.status != nil ? "Status: \(self.viewModel.movieDetailModel!.status!)" : ""
            self.labelRuntime.text = self.viewModel.movieDetailModel!.runtime != nil ? ("Runtime: \(String(self.viewModel.movieDetailModel!.runtime!)) dk") : ""
            self.labelPopularity.text = self.viewModel.movieDetailModel!.popularity != nil ? "Popularity: \(String(self.viewModel.movieDetailModel!.popularity ?? 0.0))" : ""
            self.labelVoteCount.text = self.viewModel.movieDetailModel!.voteCount != nil ? "VoteCount: \(String(self.viewModel.movieDetailModel!.voteCount ?? 0))" : ""
            self.labelVoteAverage.text = self.viewModel.movieDetailModel!.voteAverage != nil ? ("VoteAverage: \(String(self.viewModel.movieDetailModel!.voteAverage ?? 0.0))") : ""
            self.labelOriginalLanguage.text = "Original Language: \(self.viewModel.movieDetailModel!.originalLanguage ?? "")"
            self.labelReleaseDate.text = self.viewModel.movieDetailModel!.releaseDate != nil ? "Release Date: \(self.viewModel.movieDetailModel!.releaseDate!)" : ""
            self.textViewOverView.text = self.viewModel.movieDetailModel!.overview != nil ? "OverView: \(self.viewModel.movieDetailModel!.overview!)" : ""

            var itemString: String = ""
            if let spokenLanguages = self.viewModel.movieDetailModel!.spokenLanguages{
                itemString.removeAll()
                for (index, item) in spokenLanguages.enumerated()
                {
                    itemString.append(item.name!)
                    if index < spokenLanguages.count - 1{
                        itemString.append("-")
                    }
                }
                self.labelSpokenLanguages.text = "Spoken Languages: \(itemString)"
            }
            
            if let productionCompanies = self.viewModel.movieDetailModel!.productionCompanies {
                itemString.removeAll()
                for (index, item) in productionCompanies.enumerated() {
                    itemString.append(item.name!)
                    if index < productionCompanies.count - 1{
                        itemString.append("-")
                    }
                }
                self.labelProductionCompanies.text = "Production Companies: \(itemString)"
                
            }
            
            if let productionCountries = self.viewModel.movieDetailModel!.productionCountries {
                itemString.removeAll()
                for (index, item) in productionCountries.enumerated() {
                    itemString.append(item.name!)
                    if index < productionCountries.count - 1 {
                        itemString.append("-")
                    }
                }
                self.labelProductionCountries.text = "Production Countries: \(itemString)"
            }
            if let genres = self.viewModel.movieDetailModel!.genres {
                itemString.removeAll()
                for (index, item) in genres.enumerated() {
                    itemString.append(item.name!)                    
                    if index < genres.count - 1 {
                        itemString.append("-")
                    }
                }
                self.labelGenre.text = "Genres: \(itemString)"
            }
        }
        // cast'i göstermek için collection vb oluştur
        //        viewModel.updateUIHandlerCredits = { [weak self] in
        //            guard let self = self else { return }
        //            let url = URL(string: "http://image.tmdb.org/t/p/w500//\(self.viewModel.movieCreditsModel.posterPath!)")
        //            self.movieImageView.kf.setImage(with: url)
        //            self.titleLabel.text = self.viewModel.movieCreditsModel!.title
        //        }
        
        viewModel.getMovieDetailData(id: self.movieID!)
        //        viewModel.getMovieCreditsData(id: self.movieID!)
    
    }
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
}


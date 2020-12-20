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
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()
    
    lazy var contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 500)
    
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
        updateUI()
    }
    
    private func configureController() {
        self.view.backgroundColor = .white
        
        labelTitle.numberOfLines = 0
        labelOriginalTitle.numberOfLines = 0
        
        scrollView.bounces = false
        
        textViewOverView.isEditable = false
        textViewOverView.isScrollEnabled = false
        textViewOverView.isSelectable = false
        textViewOverView.textAlignment = .left
    }
    
    private func configureConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(labelTitle)
        containerView.addSubview(imageViewMovie)
        containerView.addSubview(labelOriginalTitle)
        containerView.addSubview(labelRuntime)
        containerView.addSubview(labelPopularity)
        containerView.addSubview(labelStatus)
        containerView.addSubview(labelGenre)
        containerView.addSubview(labelOriginalLanguage)
        containerView.addSubview(labelReleaseDate)
        containerView.addSubview(labelSpokenLanguages)
        containerView.addSubview(labelAdult)
        containerView.addSubview(textViewOverView)
        
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageViewMovie.translatesAutoresizingMaskIntoConstraints = false
        imageViewMovie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        imageViewMovie.heightAnchor.constraint(equalToConstant: 400).isActive = true
        imageViewMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageViewMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
                
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 50).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 21).isActive = true

        labelOriginalTitle.translatesAutoresizingMaskIntoConstraints = false
        labelOriginalTitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor).isActive = true
        labelOriginalTitle.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        labelOriginalTitle.trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor).isActive = true
        labelOriginalTitle.heightAnchor.constraint(equalToConstant: 21).isActive = true

        
        let stackViewStatus = UIStackView()
        stackViewStatus.axis = .vertical
        stackViewStatus.alignment = .leading
        stackViewStatus.distribution = .equalSpacing
        stackViewStatus.contentMode = .scaleToFill
        containerView.addSubview(stackViewStatus)

        stackViewStatus.addArrangedSubview(labelTitle)
        stackViewStatus.addArrangedSubview(labelOriginalTitle)
        stackViewStatus.addArrangedSubview(labelRuntime)
        stackViewStatus.addArrangedSubview(labelPopularity)
        stackViewStatus.addArrangedSubview(labelAdult)
        stackViewStatus.addArrangedSubview(labelGenre)
        stackViewStatus.addArrangedSubview(labelStatus)
        stackViewStatus.addArrangedSubview(labelGenre)
        
        stackViewStatus.translatesAutoresizingMaskIntoConstraints = false
        stackViewStatus.topAnchor.constraint(equalTo: labelOriginalTitle.bottomAnchor, constant: 20).isActive = true
        stackViewStatus.leadingAnchor.constraint(equalTo: labelOriginalTitle.leadingAnchor).isActive = true
        stackViewStatus.trailingAnchor.constraint(equalTo: labelOriginalTitle.trailingAnchor).isActive = true
        
        
        
        
        textViewOverView.translatesAutoresizingMaskIntoConstraints = false
        textViewOverView.topAnchor.constraint(equalTo: labelOriginalTitle.bottomAnchor, constant: 10).isActive = true
        textViewOverView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        textViewOverView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
//        textViewOverView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
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
            self.labelGenre.text = self.viewModel.movieDetailModel!.genres != nil ? "Genre: \(self.viewModel.movieDetailModel!.genres![0].name ?? "")" : ""
            self.labelStatus.text = self.viewModel.movieDetailModel!.status != nil ? "Status: \(self.viewModel.movieDetailModel!.status!)" : ""
            self.labelRuntime.text = self.viewModel.movieDetailModel!.runtime != nil ? ("Runtime: \(String(self.viewModel.movieDetailModel!.runtime!)) dk") : ""
            self.labelPopularity.text = self.viewModel.movieDetailModel!.popularity != nil ? "Popularity: \(String(self.viewModel.movieDetailModel!.popularity ?? 0.0))" : ""
            self.labelVoteCount.text = self.viewModel.movieDetailModel!.voteCount != nil ? "VoteCount: \(String(self.viewModel.movieDetailModel!.voteCount ?? 0))" : ""
            self.labelVoteAverage.text = self.viewModel.movieDetailModel!.voteAverage != nil ? ("VoteAverage: \(String(self.viewModel.movieDetailModel!.voteAverage ?? 0.0))") : ""
            self.labelOriginalLanguage.text = "Original Language: \(self.viewModel.movieDetailModel!.originalLanguage ?? "")"
//     TODO       self.labelSpokenLanguages.text = String(format: "%@", self.viewModel.movieDetailModel!.spokenLanguages ?? "")
            self.labelReleaseDate.text = self.viewModel.movieDetailModel!.releaseDate != nil ? "Release Date: \(self.viewModel.movieDetailModel!.releaseDate!)" : ""
            self.textViewOverView.text = self.viewModel.movieDetailModel!.overview != nil ? "OverView: \(self.viewModel.movieDetailModel!.overview!)" : ""
            
//  TODO          self.labelProductionCompanies.text = String(format: "%@", self.viewModel.movieDetailModel!.productionCompanies ?? "").map {"\($0)"}.reduce("") { $0 + $1 }
//       TODO     self.labelProductionCountries.text = String(format: "%@", self.viewModel.movieDetailModel!.productionCountries ?? "").map {"\($0)"}.reduce("") { $0 + $1 }
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


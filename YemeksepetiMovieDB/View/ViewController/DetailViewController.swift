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
    lazy var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal        
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    lazy var stackViewContainer: UIStackView = {
        var stackViewContainer = UIStackView()
        stackViewContainer.axis = .vertical
        stackViewContainer.alignment = .leading
        stackViewContainer.distribution = .fillProportionally
        stackViewContainer.spacing = 10
        stackViewContainer.contentMode = .scaleToFill
        return stackViewContainer
    }()
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()
    
    lazy var contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 800)
    
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
        initUI()
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
        self.collectionView.delegate = self
        self.collectionView.dataSource = self                
        collectionView.backgroundColor = .white
        
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: Cells.castCell)
    }
    
    private func configureConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.addSubview(collectionView)
        
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    private func initUI() {
        
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
            
            self.labelTitle.text = (self.viewModel.movieDetailModel!.title != nil && !self.viewModel.movieDetailModel!.title!.isEmpty) ? "Title: \(self.viewModel.movieDetailModel!.title!)" : ""
            
            self.labelOriginalTitle.text = (self.viewModel.movieDetailModel!.title != nil && !self.viewModel.movieDetailModel!.title!.isEmpty) ? "Original Title: \(self.viewModel.movieDetailModel!.title!)" : ""
            
            self.labelAdult.text = self.viewModel.movieDetailModel!.adult != nil ? "Movie for: \((self.viewModel.movieDetailModel!.adult!) ? AdultTypeEnum.Adult.rawValue : AdultTypeEnum.AllAges.rawValue)" : ""
            
            self.labelStatus.text = (self.viewModel.movieDetailModel!.status != nil && !self.viewModel.movieDetailModel!.status!.isEmpty) ? "Status: \(self.viewModel.movieDetailModel!.status!)" : ""
            
            self.labelRuntime.text = self.viewModel.movieDetailModel!.runtime != nil ? ("Runtime: \(String(self.viewModel.movieDetailModel!.runtime!)) dk") : ""
            
            self.labelPopularity.text = self.viewModel.movieDetailModel!.popularity != nil ? "Popularity: \(String(self.viewModel.movieDetailModel!.popularity!))" : ""
            
            self.labelVoteCount.text = self.viewModel.movieDetailModel!.voteCount != nil ? "Vote Count: \(String(self.viewModel.movieDetailModel!.voteCount!))" : ""
            
            self.labelVoteAverage.text = self.viewModel.movieDetailModel!.voteAverage != nil ? ("Vote Average: \(String(self.viewModel.movieDetailModel!.voteAverage!))") : ""
            
            self.labelOriginalLanguage.text = (self.viewModel.movieDetailModel!.originalLanguage != nil && !self.viewModel.movieDetailModel!.originalLanguage!.isEmpty) ? "Original Language: \(self.viewModel.movieDetailModel!.originalLanguage!)" : ""
            
            self.labelReleaseDate.text = (self.viewModel.movieDetailModel!.releaseDate != nil && !self.viewModel.movieDetailModel!.releaseDate!.isEmpty) ? "Release Date: \(self.viewModel.movieDetailModel!.releaseDate!)" : ""
            
            self.textViewOverView.text = (self.viewModel.movieDetailModel!.overview != nil && !self.viewModel.movieDetailModel!.overview!.isEmpty) ? "Overview: \(self.viewModel.movieDetailModel!.overview!)" : ""

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
                self.labelProductionCompanies.text = !itemString.isEmpty ? "Production Companies: \(itemString)" : ""
                
            }
            
            if let productionCountries = self.viewModel.movieDetailModel!.productionCountries {
                itemString.removeAll()
                for (index, item) in productionCountries.enumerated() {
                    itemString.append(item.name!)
                    if index < productionCountries.count - 1 {
                        itemString.append("-")
                    }
                }
                self.labelProductionCountries.text = !itemString.isEmpty ? "Production Countries: \(itemString)" : ""
            }
            if let genres = self.viewModel.movieDetailModel!.genres {
                itemString.removeAll()
                for (index, item) in genres.enumerated() {
                    itemString.append(item.name!)                    
                    if index < genres.count - 1 {
                        itemString.append("-")
                    }
                }
                self.labelGenre.text = !itemString.isEmpty ? "Genres: \(itemString)" : ""
            }
                        
        }
        
        viewModel.updateUIHandlerCredits = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.getMovieDetailData(id: self.movieID!)
        viewModel.getMovieCreditsData(id: self.movieID!)
    
    }
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.castCell, for: indexPath) as! CastCell
        cell.cellResultModel = self.viewModel.movieCreditsModel[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.userPressedCast(at: indexPath)
        
        let castVC = CastViewController()
        if let navigation = self.navigationController {
            navigation.pushViewController(castVC, animated: true)
            castVC.castID = self.viewModel.castID
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width / 3, height: self.collectionView.frame.height)
    }
}


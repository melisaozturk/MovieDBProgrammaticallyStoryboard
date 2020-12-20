//
//  DetailViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var movieImageView = UIImageView()
    
    var movieID: Int?
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()
        
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        configureConstraints()
        updateUI()
    }
    
    private func configureController() {
        self.view.backgroundColor = .white
        
        
        titleLabel.numberOfLines = 0
        
    }
    
    private func configureConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(movieImageView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 16/9, constant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true
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
            self.movieImageView.kf.setImage(with: url)
            self.titleLabel.text = self.viewModel.movieDetailModel!.title
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

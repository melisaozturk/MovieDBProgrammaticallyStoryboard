//
//  MovieCell.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    private var titleLabel = UILabel()
    private var subtitleTextView = UITextView()
    private var movieImageView = UIImageView()
    
    var cellResultModel : PopularResult? {
        didSet {
            titleLabel.text = cellResultModel?.title
            subtitleTextView.text = cellResultModel?.overview
            let url = URL(string: "http://image.tmdb.org/t/p/w500//\(cellResultModel!.posterPath!)")
            movieImageView.kf.setImage(with: url)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill

        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupViews() {
        addSubview(movieImageView)
        addSubview(titleLabel)
        
        //                movieImageView constraints
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 16/9, constant: 12).isActive = true
        
        //                titleLabel constraints
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
}

//
//  CastCell.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 20.12.2020.
//

import UIKit
import Kingfisher

class CastCell: UICollectionViewCell {
    
    private var movieImageView = UIImageView()
    
    var cellResultModel: MovieCast? {
        didSet {
            let url = URL(string: "http://image.tmdb.org/t/p/w500//\(cellResultModel!.profilePath ?? "")")
            movieImageView.kf.setImage(with: url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFit
        
    }
    
    private func configureConstraints() {
        addSubview(movieImageView)
        
        //                movieImageView constraints
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 16/9, constant: 12).isActive = true        
        
    }
    
}

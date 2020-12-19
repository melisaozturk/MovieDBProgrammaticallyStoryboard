//
//  DetailViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var movieImageView = UIImageView()
    
    var movieID: Int?
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .cyan
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        configureConstraints()
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
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20).isActive = true
    }
}

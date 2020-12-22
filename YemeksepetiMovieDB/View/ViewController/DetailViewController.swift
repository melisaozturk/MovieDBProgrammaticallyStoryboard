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
    private var tableView = UITableView()
    
    lazy var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal        
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel(id: self.viewModel.id!)
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
        configuteTableView()
        configureCollectionView()
        initUI()
    }
    
    init(viewModel: MovieDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureController() {
        self.view.backgroundColor = .white
        
        scrollView.bounces = false
    }
    
    private func configuteTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .white        
        tableView.register(DetailCell.self, forCellReuseIdentifier: Cells.detailCell)
    }
    
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self                
        collectionView.backgroundColor = .white
        
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: Cells.castCell)
    }
    
    private func configureConstraints() {
                
        containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).priority = .defaultLow
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
                        
        containerView.addSubview(imageViewMovie)
        containerView.addSubview(tableView)
        containerView.addSubview(collectionView)
        
        imageViewMovie.translatesAutoresizingMaskIntoConstraints = false
        imageViewMovie.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageViewMovie.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imageViewMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageViewMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: imageViewMovie.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
            let url = URL(string: "http://image.tmdb.org/t/p/w500//\(self.viewModel.movieDetailModel.posterPath)") //URL i gönder viewmodel den
            self.imageViewMovie.kf.setImage(with: url)
            self.tableView.reloadData()
        }
        
        viewModel.updateUIHandlerCredits = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        viewModel.getMovieDetailData()
        viewModel.getMovieCreditsData()
    
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDetailCells
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.detailCell , for: indexPath) as! DetailCell
        cell.selectionStyle = .none
        
        cell.cellResultModel = self.viewModel.labelModel[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCastCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.castCell, for: indexPath) as! CastCell
        cell.cellResultModel = self.viewModel.movieCreditsModel[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.userPressedCast(at: indexPath)
        
        let castVC = DetailViewController(viewModel: MovieDetailViewModel(id: self.viewModel.id!))
        if let navigation = self.navigationController {
            navigation.pushViewController(castVC, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width / 3, height: self.collectionView.frame.height)
    }
}


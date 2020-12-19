//
//  ViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

struct Cells {
    static let movieCell = "MovieCell"
}

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    private var searchBar = UISearchBar()
    
    lazy var viewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configuteTableView()
        configureSearchBar()
        configureController()
        updateUI()
        
    }
    
    private func configureNavigation() {
        navigationItem.title = "Home"
        //        navigationController?.navigationBar.isTranslucent = false
        
        //        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        //        titleLabel.text = "Home"
        //        titleLabel.textColor = .white
        //        titleLabel.font = UIFont.systemFont(ofSize: 20)
        //        navigationItem.titleView = titleLabel
    }
       
    private func configureSearchBar() {
//        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
//        searchBar.delegate = self
    }
    
    private func configuteTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(MovieCell.self, forCellReuseIdentifier: Cells.movieCell)
    }
    
    private func configureController() {
        
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        
        searchBar.backgroundColor = .white
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
            self.tableView.reloadData()
        }
        
        viewModel.getPopularData()
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell , for: indexPath) as! MovieCell
        cell.selectionStyle = .none
        cell.cellResultModel = viewModel.popularModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath)
        
        let detailvc = DetailViewController()
        if let navigation = self.navigationController {
            navigation.pushViewController(detailvc, animated: true)
            detailvc.movieID = self.viewModel.movieID
        }
    }
    
    
}



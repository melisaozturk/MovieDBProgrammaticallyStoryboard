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
    
    var tableView = UITableView()
    
    lazy var viewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigation()
        self.configureTableView()
        self.updateUI()
        
    }
    
    private func configureTableView() {
        self.view.addSubview(tableView)
        tableView.pin(to: self.view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(MovieCell.self, forCellReuseIdentifier: Cells.movieCell)
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
    
    private func updateUI() {
        
        viewModel.showAlertHandler = { [weak self] in
            guard let self = self else { return }
            if let message = self.viewModel.alertMessage {
                UIManager.shared().showMessage(viewController: self, message: message)
            }
        }
        
        //        viewModel.updateLoadingStatusHandler = { [weak self] in
        //            guard let self = self else { return }
        //            DispatchQueue.main.async {
        //                let isLoading = self.viewModel.isLoading
        //                if isLoading {
        //                    UIManager.shared().showLoading(view: self.view)
        ////                    UIView.animate(withDuration: 0.2, animations: {
        ////                        self.tableView.alpha = 0.0
        ////                    })
        //                }else {
        //                    UIManager.shared().removeLoading(view: self.view)
        ////                    UIView.animate(withDuration: 0.2, animations: {
        ////                        self.tableView.alpha = 1.0
        ////                    })
        //                }
        //            }
        //        }
        
        viewModel.reloadTableViewHandler = { [weak self] in
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
        let cellModel = viewModel.getCellModel(at: indexPath)
        cell.cellResultModel = cellModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath)
        
        let detailvc = DetailViewController()
        if let navigation = self.navigationController {
            navigation.pushViewController(detailvc, animated: true)
        }
        //        self.detailVC?.gotoDetail(viewModel: self.viewModel)
        
    }
    
    
}



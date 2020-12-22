//
//  ViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

struct Cells {
    static let movieCell = "MovieCell"
    static let castCell = "CastCell"
    static let detailCell = "DetailCell"
}

class ViewController: UIViewController {
    
    private var tableView = UITableView()
    private var searchBar = UISearchBar()
    
    lazy var viewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configuteTableView()
        configureController()
        initUI()
        addDoneButtonOnKeyboard()
    }
    
    init(viewModel: MovieViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        navigationItem.title = "Home"
        self.searchBar.delegate = self
        self.view.backgroundColor = UIColor.gray
    }
    
    private func configuteTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(MovieCell.self, forCellReuseIdentifier: Cells.movieCell)
    }
    
    private func configureController() {
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        searchBar.backgroundColor = .white
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let topPadding = window.safeAreaInsets.top
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationController!.navigationBar.frame.size.height + topPadding).isActive = true
        } else {
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationController!.navigationBar.frame.size.height).isActive = true
        }
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
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
            if self.viewModel.isLoading {
                    UIUtil.shared().showLoading(view: self.view)
                }else {
                    UIUtil.shared().removeLoading(view: self.view)
            }
        }
        
        viewModel.updateUIHandler = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.getPopularData()
    }
 
    private func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.tintColor = UIColor.black
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.searchBar.inputAccessoryView = doneToolbar
    }
        
    @objc func doneButtonAction() {
        view.endEditing(true)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieCell , for: indexPath) as! MovieCell
        cell.selectionStyle = .none
                
            if indexPath.row < viewModel.numberOfCells {
                cell.cellResultModel = viewModel.returnData[indexPath.row]
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {       
        self.viewModel.userPressed(at: indexPath)
        
        let detailVC = DetailViewController(viewModel: MovieDetailViewModel(id: self.viewModel.id!))
        if let navigation = self.navigationController {
            navigation.pushViewController(detailVC, animated: true)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

            viewModel.showAlertHandler = { [weak self] in
                guard let self = self else { return }
                if let message = self.viewModel.alertMessage {
                    UIUtil.shared().showMessage(viewController: self, message: message)
                }
            }
            
            viewModel.updateLoadingStatusHandler = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if self.viewModel.isLoading {
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
            
            self.viewModel.getSearchMovies(searchKey: searchText)
    }    
}

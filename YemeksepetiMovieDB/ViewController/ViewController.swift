//
//  ViewController.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNavigation()
        self.registerTableView()
        self.updateUI()
        
    }
    
    private func registerTableView() {
        tableView?.backgroundColor = .white
        tableView?.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    private func registerNavigation() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    private func updateUI() {
        UIManager.shared().showLoading(view: self.view)
        self.viewModel.getPopularData(completion: { [weak self] response in
            UIManager.shared().removeLoading(view: self!.view)
            if let _ = self {
                self!.tableView.reloadData()
            }
        }, completionHandler: { [weak self] error in
            if let _ = self {
                UIManager.shared().tabbarErrorHandle(viewController: self!, message: "Bir hata oluştu.")
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        return cell
    }
    
}






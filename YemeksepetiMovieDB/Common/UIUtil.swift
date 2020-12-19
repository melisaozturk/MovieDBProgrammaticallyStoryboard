//
//  UIUtil.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 18.12.2020.
//

import Foundation
import UIKit

protocol UIManagerDelegate {
    func showLoading(view: UIView)
    func removeLoading(view:UIView)
}

class UIManager: UIManagerDelegate {
    
    private let loading = Loading()
    private static var sharedInstance: UIManager?
    
    public class func shared() -> UIManager {
        if sharedInstance == nil {
            sharedInstance = UIManager()
        }
        return sharedInstance!
    }
    
    
    func showLoading(view: UIView) {
        view.addSubview(self.loading)
        view.isUserInteractionEnabled = false
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loading.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loading.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loading.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func removeLoading(view:UIView){
        view.isUserInteractionEnabled = true
        loading.removeFromSuperview()
    }
    
    func errorHandle(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            viewController.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func tabbarErrorHandle(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            viewController.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}

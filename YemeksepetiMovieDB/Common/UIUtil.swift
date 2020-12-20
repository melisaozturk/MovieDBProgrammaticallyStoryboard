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

class UIUtil: UIManagerDelegate {
    
    private let loading = Loading()
    private static var sharedInstance: UIUtil?
    
    public class func shared() -> UIUtil {
        if sharedInstance == nil {
            sharedInstance = UIUtil()
        }
        return sharedInstance!
    }
    
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    let container: UIView = UIView()

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
    
    func showMessage(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            viewController.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

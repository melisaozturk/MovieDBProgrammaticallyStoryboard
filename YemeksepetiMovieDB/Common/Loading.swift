//
//  Loading.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

class Loading: UIView {
    
    private var view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup(){
        
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .black
        self.view.alpha = 0.8
        
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = self.view.center
        self.view.addSubview(activity)
        
        activity.startAnimating()
    }
}


//
//
//class Loading: UIView {
//
//    private var activity = UIActivityIndicatorView(style: .whiteLarge)
//    let container: UIView = UIView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        xibSetup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        xibSetup()
//    }
//
//    private func xibSetup(){
////        view.frame = UIScreen.main.bounds
////        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
////        addSubview(view)
//
////        container.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
//        container.backgroundColor = .black
//        container.alpha = 0.8
//
//        configureActivity()
//    }
//
//    private func configureActivity() {
//
//        activity.translatesAutoresizingMaskIntoConstraints = false
//        container.addSubview(activity)
//
//        activity.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
//        activity.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
//        activity.startAnimating()
//    }
//}

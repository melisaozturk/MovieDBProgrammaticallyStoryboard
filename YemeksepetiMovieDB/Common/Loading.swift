//
//  Loading.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

class Loading: UIView {
    
    private var view: UIView!
    private var activity = UIActivityIndicatorView(style: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup(){
//        view = loadViewFromNib()
//        view.frame = bounds
//        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
//        addSubview(view)
        loadView()
        setup()
    }
    
    private func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        view.addSubview(activity)
        
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        let bundle = Bundle(for: type(of: self))
//        var identifier = ""
//        identifier =  NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
//        let nib = UINib(nibName: identifier, bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//        return view
    }
    
    private func setup() {
        self.view.backgroundColor = .black
        self.view.alpha = 0.8
        
        //        self.activity.translatesAutoresizingMaskIntoConstraints = false
//        let activity = UIActivityIndicatorView(style: .whiteLarge)
//        activity.center = self.view.center
//        self.view.addSubview(activity)
//        activity.startAnimating()
        
        //        addConstraint(NSLayoutConstraint(item: self.activity!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: self.activity!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: self.activity!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //        self.addSubview(self.activity)
        
    }
}

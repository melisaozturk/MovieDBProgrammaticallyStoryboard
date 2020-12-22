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
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        view.frame = UIScreen.main.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        self.view.backgroundColor = .black
        self.view.alpha = 0.8
        
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = self.view.center
        self.view.addSubview(activity)
        
        activity.startAnimating()
    }
}

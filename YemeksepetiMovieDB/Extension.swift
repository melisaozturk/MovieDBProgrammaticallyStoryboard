//
//  Extension.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

extension UIView {
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        }
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}



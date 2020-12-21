//
//  IViewModel.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import Foundation

protocol IViewModel {
    
    var updateUIHandler: (()->())? { get set }
    var showAlertHandler: (()->())? { get set }
    var updateLoadingStatusHandler: (()->())? { get set }
       
}

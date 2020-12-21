//
//  AppDelegate.swift
//  YemeksepetiMovieDB
//
//  Created by melisa öztürk on 19.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: ViewController(viewModel: MovieViewModel()))
        
        UINavigationBar.appearance().barTintColor =
            UIColor.init(red: 230/255, green: 32/255, blue: 21/255, alpha: 1)
                        
        return true
    }

}


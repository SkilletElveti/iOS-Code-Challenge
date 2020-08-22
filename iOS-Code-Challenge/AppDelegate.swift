//
//  AppDelegate.swift
//  iOS-Code-Challenge
//
//  Created by Shubham Vinod Kamdi on 19/08/20.
//  Copyright © 2020 Persausive Tech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var navigation: UINavigationController?
    var viewController: ViewController = ViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Setting up the
        navigation = UINavigationController()
        navigation?.pushViewController(viewController, animated: true)
        
        //Setting the rooot view controller
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        return true
    }




}


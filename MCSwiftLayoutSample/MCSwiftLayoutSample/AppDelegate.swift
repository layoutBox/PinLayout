//
//  AppDelegate.swift
//  MCSwiftLayoutSample
//
//  Created by DION, Luc (MTL) on 2017-02-27.
//  Copyright © 2017 mcswiftlayyout.mirego.com. All rights reserved.
//

import UIKit
import MCSwiftLayout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = UINavigationController(rootViewController: MenuViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}


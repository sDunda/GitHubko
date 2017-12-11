//
//  AppDelegate.swift
//  GitHubko
//
//  Created by D&M on 21.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let vc = MainScreenViewController(nibName: "MainScreenViewController", bundle: nil)
        let nc = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        return true
    }

}

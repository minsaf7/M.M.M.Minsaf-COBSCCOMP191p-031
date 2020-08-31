//
//  AppDelegate.swift
//  NIBM COVID19
//
//  Created by Mohamed Minsaf on 8/22/20.
//  Copyright © 2020 Mohamed Minsaf. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        

        window = UIWindow()

        window?.makeKeyAndVisible()

        window?.rootViewController = UINavigationController(rootViewController: UpdateViewController())

        

        return true

    }

    // MARK: UISceneSession Lifecycle

}

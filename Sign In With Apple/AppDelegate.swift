//
//  AppDelegate.swift
//  Sign In With Apple
//
//  Created by Meet Ratanpara on 17/01/20.
//  Copyright © 2020 Meet Ratanpara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        if !UserDefaults.standard.bool(forKey: "isAppleSignIn_FirstTime") {
            
            UserDefaults.standard.set("", forKey: "User_AppleID")
            
            UserDefaults.standard.set("", forKey: "User_Email")
            UserDefaults.standard.set("", forKey: "User_FirstName")
            UserDefaults.standard.set("", forKey: "User_LastName")
            UserDefaults.standard.set("", forKey: "User_Password")
            
            UserDefaults.standard.set(true, forKey: "isAppleSignIn_FirstTime")
            UserDefaults.standard.synchronize()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


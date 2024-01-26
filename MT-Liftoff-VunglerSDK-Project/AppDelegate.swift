//
//  AppDelegate.swift
//  MT-Liftoff-VunglerSDK-Project
//
//  Created by Matthew Tripodi on 1/25/24.
//

import UIKit
import VungleAdsSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //MARK: -  Initialize the Vungle SDK
        VungleAds.initWithAppId(Keys.AppID) { error in
            if let error = error {
                print("Error initializing SDK")
            } else {
                print("Init is complete")
            }
        }
        
        if (VungleAds.isInitialized()) {
            print("SDK is initialized")
        } else {
            print("SDK is NOT initialized")
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


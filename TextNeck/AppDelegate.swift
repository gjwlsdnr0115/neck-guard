//
//  AppDelegate.swift
//  TextNeck
//
//  Created by 허진욱 on 2021/04/13.
//

import UIKit

let userGoalKey = "userGoalKey"
let userCurrentKey = "userCurrentKey"
let initialLaunchKey = "initialLaunchKey"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !UserDefaults.standard.bool(forKey: initialLaunchKey) {
            
//            let defaultSettings = [userGoalKey: 30, userCurrentKey: 0] as [String: Any]
//            UserDefaults.standard.register(defaults: defaultSettings)
            UserDefaults.standard.set(30, forKey: userGoalKey)
            UserDefaults.standard.set(0, forKey: userCurrentKey)
            UserDefaults.standard.set(true, forKey: initialLaunchKey)
            
            print("initial launch")
        }
        
        DataManager.shared.setup(modelName: "DataModel")
        
        
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

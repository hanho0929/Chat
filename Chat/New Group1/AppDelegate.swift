//
//  AppDelegate.swift
//  Chat
//
//  Created by hanho on 10/13/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
            
        } catch {
            print("Error initialing new realm , \(error)")
        }
        
        
        return true
    }



}


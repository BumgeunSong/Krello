//
//  TestingAppDelegate.swift
//  KrelloTests
//
//  Created by Bumgeun Song on 2022/05/06.
//

import UIKit

@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("✅ Launching with testing app delegate")
        return true
    }
}

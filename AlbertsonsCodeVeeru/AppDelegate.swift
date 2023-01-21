//
//  AppDelegate.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

extension UIWindow {
    static var isPortrait: Bool {
        guard let wind = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }
        return wind.interfaceOrientation == .portrait
    }
}


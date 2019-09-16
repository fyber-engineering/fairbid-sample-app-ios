//
//  AppDelegate.swift
//  Fyber FairBid
//
//  Created by Nikita on 24/03/2019.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let options = FYBStartOptions()
        options.autoRequestingEnabled = false
        options.logLevel = .verbose

        FairBid.start(withAppId: "109613", options: options)

        return true
    }

}

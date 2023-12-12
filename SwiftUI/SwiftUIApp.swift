//
//  SwiftuiApp.swift
//  Swiftui
//
//  Created by Stanislav Tomych on 12.12.2023.
//  Copyright © 2023 Fyber. All rights reserved.
//

import SwiftUI
import FairBidSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let options = FYBStartOptions()
        options.autoRequestingEnabled = false
        options.logLevel = .verbose

        FairBid.start(withAppId: "109613", options: options)

        return true
    }
}

@main
struct MainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

//
//
// Copyright (c) 2019 Fyber. All rights reserved.
//
//

import FairBidSDK
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let options = FYBStartOptions()
        options.autoRequestingEnabled = false
        options.logLevel = .verbose

        FairBid.start(withAppId: "111691", options: options)

        return true
    }

}

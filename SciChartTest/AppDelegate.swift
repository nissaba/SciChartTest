//
//  AppDelegate.swift
//  SciChartTest
//
//  Created by Pascale Beaulac on 2020-01-31.
//  Copyright © 2020 Notio Technologies inc. All rights reserved.
//

import UIKit
import SciChart

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        SCIChartSurface.setRuntimeLicenseKey("ZoAloIAi2SRZ/DxDTBGw5HOFHGy8bpqqkVZ+JblIWpJ1vhE6Fgl+czTzOTbSI6Q5iXNdgVkHi/SRCTzLzD+RlN41kp5ykl9131Z65k1QXt7imN7fFAdjQ80amvL0D1JEN7eoAuHKMPA9sUjUjJATYdJeSd+3P6+2UUwxpBZEt85P/zzRh0awz3omHxr50EM4oUFm0SdSfhjbkv0GisV+iZXrODKryafc2MiSmwqfQGgS4NUMyIevQhqhNSVpi0i7lckssJDIEsSYRNH9S+uf+DQU711LPCsvVaMJlI7dFpR3wNRqhD8gOA21WzVgcANb0tTmUgMBNa9up2m56tpFIExy3ehXaCgahzvCgeb6jduFygK6cqJicclebYSnV2x/ngncVPk0JU/8kDTPJq/nKyj4+hWpL05mdAXQd6y0cNqp4WadBwPE/7o5UdjZWNb7b56aHKynD5r5X4zDay+d2lS83sRt7wGnRb5Q7ZEp2jc/cHga2JGOSFgbjueZj8WRuN4piQqZRlW+GtPwawFqgLMo/M197JKWIKoZ9krZHkyqc/7586U0d8AQh/2kfvt9PQa+")
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


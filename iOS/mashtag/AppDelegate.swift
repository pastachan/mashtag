//
//  AppDelegate.swift
//  Mashtag
//
//  Created by Austin Chan on 7/8/15.
//  Copyright (c) 2015 Awoes. All rights reserved.
//
//  Lovingly from 🇺🇸
//  ❤️🍻☺️, 💣🔫😭
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var animator = Animator()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var navigation = UINavigationController(rootViewController: HomeViewController(nibName: "HomeViewController", bundle: nil))
        navigation.delegate = self
        navigation.navigationBar.hidden = true
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        // enable Google Analytics tracking
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")

        var gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true
        gai.logger.logLevel = GAILogLevel.None

        // enable Facebook metric tracking, it makes them happy
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        // enable Facebook metric tracking
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = operation == UINavigationControllerOperation.Push ? true : false
        return animator
    }

    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}


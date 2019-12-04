//
//  AppDelegate.swift
//  DeepLink
//
//  Created by Suresh Shiga on 03/12/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        /*
 pass url like this
         custom schema name = deeplinkmyapp
          host name                  = pagename
         message name           = name=Apple%20Mac%20Book%20Air
        deeplinkmyapp://pagename?name=Apple%20Mac%20Book%20Air
*/
        
        let urlComponent = URLComponents.init(url: url, resolvingAgainstBaseURL: true)
        
        print("url: \(url)")
        print("url host: \(String(describing: urlComponent?.host))")
        print("url path: \(String(describing: urlComponent?.path))")
        
        var componentPath = url.path.components(separatedBy: "/")
        componentPath.removeFirst()
        
        if url.host! == "product" {
            // if RootviewController is NavigationController
            //rootViewisNavigationController(urlComponent: urlComponent)
            
            // if RootViewController is TabBarController
            //rootViewControllerisOnlyTabBarController(urlComponent: urlComponent)
            
            // if RootViewController is TabBarController
            rootViewControllerisTabBarController(urlComponent: urlComponent)
        }
        return true
    }
    
    // MARK:- Root NavigationController
    
    private func rootViewisNavigationController(urlComponent: URLComponents?){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVc = storyBoard.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        secondVc.descriptionString = urlComponent?.queryItems?.first?.value
        let navVC = self.window?.rootViewController as? UINavigationController
        navVC?.pushViewController(secondVc, animated: true)
    }
    
    // Mark:- Root TabBarController
    
    private func rootViewControllerisOnlyTabBarController(urlComponent: URLComponents?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC,
            let tabBar = window?.rootViewController as? UITabBarController {
            secondVC.descriptionString = urlComponent?.queryItems?.first?.value
            tabBar.selectedViewController?.present(secondVC, animated: true, completion: nil)
        }
    }
    
    // Mark: Root TabBarController with NavigationController
    
    private func rootViewControllerisTabBarController(urlComponent: URLComponents?) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       if let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC,
        let tabBar = window?.rootViewController as? UITabBarController,
        let navVC = tabBar.selectedViewController as? UINavigationController {
        tabBar.selectedIndex = 1
        secondVC.descriptionString = urlComponent?.queryItems?.first?.value
        navVC.pushViewController(secondVC, animated: true)
        }
    }
    
  

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


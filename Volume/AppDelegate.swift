//
//  AppDelegate.swift
//  Volume
//
//  Created by Teng Siong Ong on 1/14/17.
//  Copyright © 2017 Teng Siong Ong. All rights reserved.
//

import UIKit
import MediaPlayer
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  fileprivate let volumeControl: UISlider = MPVolumeView().volumeSlider
  fileprivate var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if WCSession.isSupported() {
      session = WCSession.default()
    }
    
    return true
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

// MARK: - WCSessionDelegate

extension AppDelegate: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    // Do nothing
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    // Do nothing
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    // Do nothing
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    guard let request = message["request"] as? String else { return }
    
    switch request {
    case "volume_set":
      guard let volume = message["volume"] as? Int else { return }
    
      let newVolume = Double(volume) / 100
      volumeControl.value = Float(newVolume)
    default:
      break
    }
  }
}


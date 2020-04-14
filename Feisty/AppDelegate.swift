//
//  AppDelegate.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/02/04.
//  Copyright © 2020 DVT. All rights reserved.
//

import UIKit
import OHHTTPStubs
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      setUpStubs()
      setUpFirebase()
      return true
    }
  
  private func setUpFirebase() {
    FirebaseApp.configure()
  }
  
  private func setUpStubs() {
    
    let option = ProcessInfo.processInfo.arguments.contains("-UseStubs")
    
    guard option == true else {
      return
    }
    
    stub(condition: isHost("api.steampowered.com")) { _ in
      
      let stubPath = OHPathForFile("gameList.json", type(of: self))
      return HTTPStubsResponse(fileAtPath: stubPath!,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
    stub(condition: isHost("store.steampowered.com") && isPath("/api/appdetails")) { request in
      
      guard let queries = request.url?.query else {
        return HTTPStubsResponse()
      }
      
      var index = queries.firstIndex(of: "=") ?? queries.startIndex
      index = queries.index(after: index)
      
      let appID = queries[index..<queries.endIndex]
      
      let stubPath = OHPathForFile("\(appID).json", type(of: self))
      
      guard let unboxedStubPath = stubPath else {
        return HTTPStubsResponse()
      }
      
      return HTTPStubsResponse(fileAtPath: unboxedStubPath,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
  }
  
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      // Called when a new scene session is being created.
      // Use this method to select a configuration to create the new scene with.
      return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      // Called when the user discards a scene session.
      // If any sessions were discarded while the application was not running,
      // this will be called shortly after application:didFinishLaunchingWithOptions.
      // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

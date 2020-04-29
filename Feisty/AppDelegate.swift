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
import CoreData
import CommonFiles

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  struct CoreDataStrings {
    static let databaseName = "FeistyDatabase"
  }
  
  struct APIStrings {
    
    static let herokuHostName = "feisty-server.herokuapp.com"
    static let loginPath = "/login"
    static let friendsPath = "/friends"
    static let friendImagePath = "/friendImage"
    
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: CoreDataStrings.databaseName)
    container.loadPersistentStores { _, error in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
      
    }
    
    return container
    
  }()
  
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
  
  private func setUpStubs() {
    
    let option = ProcessInfo.processInfo.arguments.contains("-UseStubs")
    
    guard option == true else {
      return
    }
    
    setUpSteamAPIStub()
    setUpSteamStoreAPIStub()
    setUpHerokuLoginStub()
    setUpHerokuFriendsStub()
    setUpHerokuFriendImagesPath()
    
  }
  
  private func setUpSteamAPIStub() {
    
    stub(condition: isHost("api.steampowered.com")) { _ in
      
      let stubPath = OHPathForFile("gameList.json", type(of: self))
      return HTTPStubsResponse(fileAtPath: stubPath!,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
  }
  
  private func setUpSteamStoreAPIStub() {
    
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
  
  private func setUpHerokuLoginStub() {
    
    stub(condition: (isHost(APIStrings.herokuHostName) && isPath(APIStrings.loginPath))) { request in
      
      var stubPath = OHPathForFile("loginInvalidResponse.json", type(of: self))
      
      var data: String = ""
      
      if let body = request.ohhttpStubs_httpBody {
        data = String(decoding: body, as: UTF8.self)
      }
      
      if data.contains("tiewhan") && data.contains("cat3") {
        stubPath = OHPathForFile("loginValidResponse.json", type(of: self))
      }
      
      guard let unboxedStubPath = stubPath else {
        return HTTPStubsResponse()
      }
      
      return HTTPStubsResponse(fileAtPath: unboxedStubPath,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
  }
  
  private func setUpHerokuFriendsStub() {
    
    stub(condition: isHost(APIStrings.herokuHostName) && isPath(APIStrings.friendsPath)) { _ in
      
      let stubPath = OHPathForFile("friendsResponse.json", type(of: self))
      
      guard let unboxedStubPath = stubPath else {
        return HTTPStubsResponse()
      }
      
      return HTTPStubsResponse(fileAtPath: unboxedStubPath,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
  }
  
  private func setUpHerokuFriendImagesPath() {
    
    stub(condition: (isHost(APIStrings.herokuHostName) && isPath(APIStrings.friendImagePath))) { _ in
      
      let stubPath = OHPathForFile("friendImageResponse.json", type(of: self))
      
      guard let unboxedStubPath = stubPath else {
        return HTTPStubsResponse()
      }
      
      return HTTPStubsResponse(fileAtPath: unboxedStubPath,
                               statusCode: 200,
                               headers: ["Content-Type": "application/json"])
      
    }
    
  }
  
}

extension AppDelegate: CoreDataAppDelegate {
  
  func saveContext() {
    
    let context = persistentContainer.viewContext
    
    if context.hasChanges {
      
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
      
    }
    
  }

}

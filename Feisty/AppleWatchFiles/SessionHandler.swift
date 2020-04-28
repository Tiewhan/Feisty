//
//  SessionHandler.swift
//  Feisty
//
//  Created by Tiewhan Smith on 2020/04/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import Foundation
import WatchConnectivity

class SessionHandler: NSObject {
  
  static let shared = SessionHandler()
  var session = WCSession.default
  
  private var isSupported: Bool = {
    WCSession.isSupported()
  }()
  
  private override init() {
    super.init()
    
    if isSupported {
      session.delegate = self
      session.activate()
    }
    
  }
  
}

extension SessionHandler: WCSessionDelegate {
  
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    self.session.activate()
  }
  
  func session(_ session: WCSession,
               didReceiveMessage message: [String: Any],
               replyHandler: @escaping ([String: Any]) -> Void) {
    
      if message["request"] as? String == "version" {
        
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "No version"
        
        replyHandler(["version": versionNumber])
        
      }
    
  }
  
}

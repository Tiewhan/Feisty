//
//  InterfaceController.swift
//  FeistyWatch Extension
//
//  Created by Tiewhan Smith on 2020/04/28.
//  Copyright © 2020 DVT. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

  @IBOutlet weak var friendImage: WKInterfaceImage!
  
  private var session = WCSession.default
  
  private var isSupported: Bool = {
    WCSession.isSupported()
  }()
  
  private var isReachable: Bool {
    session.isReachable
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
      
    if isSupported {
        session.delegate = self
        session.activate()
    }
    
    super.willActivate()
  }
    
}

extension InterfaceController: WCSessionDelegate {
  
  func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
      
    WKInterfaceDevice.current().play(.notification)
    
    setImage(message: message)
    
  }
  
  private func setImage(message: [String: Any]) {
    guard let imageData = message["image"] as? Data? else {
      print("Image could not be set")
      return
    }
    
    if let data = imageData {
      
      let image = UIImage(data: data)
      friendImage.setImage(image)
      
    }
    
  }
  
}

//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Teng Siong Ong on 1/14/17.
//  Copyright © 2017 Teng Siong Ong. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
  @IBOutlet var itemPicker: WKInterfacePicker!
  
  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    super.willActivate()
    
    let pickerItems: [WKPickerItem] = (0...100).map {
      let pickerItem = WKPickerItem()
      pickerItem.contentImage = WKImage(imageName: "picker\($0).png")
      return pickerItem
    }
    itemPicker.setItems(pickerItems)

    activateSession()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  // MARK: - Private
 
  private func activateSession() {
    guard session == nil else { return }
    
    if WCSession.isSupported() {
      session = WCSession.default()
    }
  }

  // MARK: - Action
  
  @IBAction func pickerSelectedItemChanged(value: Int) {
    guard let session = session else { return }
    
    session.sendMessage(["request": "volume_set", "volume": value], replyHandler: nil, errorHandler: { (error) -> Void in
      print(error)
    })
  }
}

extension InterfaceController: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    // Do nothing
  }
}

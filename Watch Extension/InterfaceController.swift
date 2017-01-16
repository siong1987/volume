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
  @IBOutlet var button: WKInterfaceButton!
  private var pickerValue = 50 {
    didSet {
      debouncedFunction.call()
    }
  }
  private var isMuted: Bool = false {
    didSet {
      button.setTitle(isMuted ? "Unmute" : "Mute")
      
      if isMuted {
        storedVolume = pickerValue
        pickerValue = 0
      } else {
        pickerValue = storedVolume
        storedVolume = 0
      }
    }
  }
  private var storedVolume = 0
  
  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }
  private lazy var debouncedFunction: Debouncer = Debouncer(delay: 0.25, counter: 5) {
    self.setVolume(volume: self.pickerValue)
  }

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
    let pickerItems: [WKPickerItem] = (0...100).map {
      let pickerItem = WKPickerItem()
      pickerItem.contentImage = WKImage(imageName: "picker\($0).png")
      return pickerItem
    }
    itemPicker.setItems(pickerItems)
    itemPicker.setSelectedItemIndex(pickerValue)
  }
  
  override func willActivate() {
    super.willActivate()
    
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
  
  private func setVolume(volume: Int) {
    guard let session = session else { return }
    guard session.isReachable else { return }
    
    session.sendMessage(["request": "volume_set", "volume": volume], replyHandler: nil, errorHandler: { (error) -> Void in
      print(error)
    })
  }

  // MARK: - Action
  
  @IBAction func pickerSelectedItemChanged(value: Int) {
    if isMuted {
      isMuted = false
    }
    
    pickerValue = value
  }

  @IBAction func muteSpeaker(button: WKInterfaceButton) {
    isMuted = !isMuted
  }
}

extension InterfaceController: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
}

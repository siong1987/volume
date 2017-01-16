//
//  Debouncer.swift
//  Volume
//
//  Created by Teng Siong Ong on 1/15/17.
//  Copyright © 2017 Teng Siong Ong. All rights reserved.
//

import Foundation

class Debouncer: NSObject {
  var callback: (() -> ())
  var delay: Double
  var counter: Int
  var currentCounter: Int = 0
  weak var timer: Timer?
  
  init(delay: Double, counter: Int, callback: @escaping (() -> ())) {
    self.delay = delay
    self.counter = counter
    self.callback = callback
  }
  
  func call() {
    guard counter > currentCounter else {
      timer?.invalidate()
      fireNow()
      
      return
    }
   
    currentCounter = currentCounter + 1
    
    timer?.invalidate()
    let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
    timer = nextTimer
  }
  
  func fireNow() {
    currentCounter = 0
    self.callback()
  }
}

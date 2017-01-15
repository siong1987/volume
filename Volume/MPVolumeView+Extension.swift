//
//  MPVolumeView+Extension.swift
//  Volume
//
//  Created by Teng Siong Ong on 1/14/17.
//  Copyright © 2017 Teng Siong Ong. All rights reserved.
//

import MediaPlayer

extension MPVolumeView {
  var volumeSlider: UISlider { // hacking for changing volume by programing
    var slider = UISlider()
    for subview in self.subviews {
      if subview is UISlider {
        slider = subview as! UISlider
        slider.isContinuous = false
        (subview as! UISlider).value = AVAudioSession.sharedInstance().outputVolume
        return slider
      }
    }
    return slider
  }
}

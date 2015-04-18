//
//  Sound.swift
//  Hello World
//

import Foundation
import AVFoundation

class Sound {
    var audioEffect : SystemSoundID = 0
    
    init(name : String, type: String) {
        if let path  = NSBundle.mainBundle().pathForResource(name, ofType: type) {
            let pathURL = NSURL(fileURLWithPath: path)
            AudioServicesCreateSystemSoundID(pathURL as! CFURLRef, &audioEffect)
        }
    }
    
    func play() {
        AudioServicesPlaySystemSound(audioEffect)
    }
}
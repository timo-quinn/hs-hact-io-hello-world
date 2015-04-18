//
//  WinViewController.swift
//  Hello World
//

import UIKit

class WinViewController: UIViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var resultValue: Double = 0
    var bonusModeClicks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var s = "Result: "
        s += String(format: "%.2f seconds", resultValue)
        s += String(format: " %d bonus clicks", bonusModeClicks)
        
        resultsLabel.text = s
    }
    
    @IBAction func tweet(sender: AnyObject) {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0)
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var tweetController = UIActivityViewController(activityItems: ["Check Out My High Score on HS Tapped!: \(resultValue)", image], applicationActivities: nil)
        self.presentViewController(tweetController, animated: true, completion: nil)
    }
}
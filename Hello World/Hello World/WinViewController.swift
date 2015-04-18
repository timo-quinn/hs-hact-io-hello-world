//
//  WinViewController.swift
//  Hello World
//

import UIKit

class WinViewController: UIViewController {
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var resultValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //append the result to the Result Label
        var s = "Result: "
        s += String(format: "%.2f", resultValue)
        
        resultsLabel.text = s
    }
    
    @IBAction func tweet(sender: AnyObject) {
        var tweetController = UIActivityViewController(activityItems: ["Check Out My High Score: \(resultValue)"], applicationActivities: nil)
        self.presentViewController(tweetController, animated: true, completion: nil)
    }
}
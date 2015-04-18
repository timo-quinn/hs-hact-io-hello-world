//
//  ViewController.swift
//  Hello World
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var tapMe: UIView!

    var counter = 0
    var startTime: NSTimeInterval = 0
    var updateTimeTimer: NSTimer!
    
    // variable to hold the number of seconds elapsed
    var secondsElapsed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButton()
        updateButton()
    }
    
    func makeButton() {
        tapMe  = UIView()
        tapMe.bounds = CGRectMake(0, 0, 50, 50)
        tapMe.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tapMe)
        tapMe.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tappedView:")))
    }

    func tappedView(sender: AnyObject) {
        if counter == 0 {
            startTime = NSDate.timeIntervalSinceReferenceDate()
            self.updateTimeTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        }
        
        counter += 1
        updateView()
        updateButton()
    }
    
    func updateTimer() {
        let seconds = NSDate.timeIntervalSinceReferenceDate() - self.startTime
        self.timerLabel.text = "\(Int(seconds))"
    }
    
    func updateView() {
        if counter >= 10 {
            
            //stop the timer
            self.updateTimeTimer = nil
            
            //put the number of seconds into the secondsElapsed variable
            secondsElapsed = Int(NSDate.timeIntervalSinceReferenceDate() - self.startTime)

            messageLabel.text = "stop pressing the button"
            performSegueWithIdentifier("showResults", sender: self)
        } else {
            messageLabel.text = "YAY! \(counter)"
            self.updateTimeTimer = nil
        }
    }
    
    func updateButton() {
        var layer = tapMe.layer
        var color = UIColor.cyanColor().CGColor
        var xPos = random() % Int(UIScreen.mainScreen().bounds.width)
        var yPos = random() % Int(UIScreen.mainScreen().bounds.height)
        
        tapMe.center = CGPointMake(CGFloat(xPos), CGFloat(yPos))
        layer.backgroundColor = color
        layer.cornerRadius = tapMe.bounds.width/2
    }
    
    // send the timer result to the WinViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showResults") {
            var destViewController = segue.destinationViewController as! WinViewController;
            destViewController.resultValue = self.secondsElapsed
        }
    }
}


//
//  ViewController.swift
//  Hello World
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var tapMe: UIView!
    
    var speed: NSTimeInterval = 1
    var counter = 0
    var startTime: NSTimeInterval = 0
    var updateTimeTimer: NSTimer!
    var buttonSound = Sound(name: "smw_coin", type: "wav")
    
    // variable to hold the number of seconds elapsed
    var secondsElapsed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButton()
        updateButton()
        srandom(UInt32(NSDate.timeIntervalSinceReferenceDate()))
        startGame()
    }
    
    func makeButton() {
        tapMe  = UIView()
        tapMe.bounds = CGRectMake(0, 0, 50, 50)
        tapMe.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tapMe)
        tapMe.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tappedView:")))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tappedBackground")))
    }
    
    func tappedBackground() {
        updateButton()
    }
    
    func startGame() {
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.updateTimeTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }

    func tappedView(sender: AnyObject) {
        counter += 1
        updateView()
        updateButton()
        buttonSound.play()
    }
    
    func updateTimer() {
        let seconds = NSDate.timeIntervalSinceReferenceDate() - self.startTime
        self.timerLabel.text = String(format: "%.2f", seconds)
    }
    
    func updateView() {
        
        speed = 1 / Double(counter)
        
        if counter >= 15 {
            //put the number of seconds into the secondsElapsed variable
            secondsElapsed = Int(NSDate.timeIntervalSinceReferenceDate() - self.startTime)

            messageLabel.text = "Your Done!"
            performSegueWithIdentifier("showResults", sender: self)
        } else {
            messageLabel.text = "Score: \(counter)"
            self.updateTimeTimer = nil
        }
    }
    
    func randomColor() -> UIColor {
        var color = UIColor(
            red: CGFloat(arc4random_uniform(255)) / 255,
            green: CGFloat(arc4random_uniform(255)) / 255,
            blue: CGFloat(arc4random_uniform(255)) / 255,
            alpha: 1.0)
        return color
    }
    
    func updateButton() {
        UIView.animateWithDuration(speed) {
            var layer = self.tapMe.layer
            var buttonRadius = self.tapMe.bounds.width / 2
            
            var color = self.randomColor()
            
            var xPos = arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.width - buttonRadius)) + UInt32(buttonRadius)
            var yPos = arc4random_uniform(UInt32(UIScreen.mainScreen().bounds.height - buttonRadius)) + UInt32(buttonRadius)

            
            self.tapMe.center = CGPointMake(CGFloat(xPos), CGFloat(yPos))
            layer.backgroundColor = color.CGColor
            layer.cornerRadius = buttonRadius
            
            self.backgroundView.backgroundColor = self.randomColor()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showResults") {
            var destViewController = segue.destinationViewController as! WinViewController;
            destViewController.resultValue = self.secondsElapsed
        }
    }
}


//
//  ViewController.swift
//  Moodie
//
//  Created by Ilya Ilyankou and Anastatija Mensikova on 11/10/15.
//  Copyright © 2015 Ilya Ilyankou and Anastatija Mensikova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let KEYWORDS_NUMBER = 35;
    let PROPERTIES_NUMBER = 11;
    
    var moodButtons : [(UIButton, String, String, Int)] = []
    var keywords = Keywords()
    var currentView = 1
    var allowedToSwipe = 0
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    @IBOutlet weak var webViewBackground: UIWebView!
    
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var keywordsSet: UIView!
    @IBOutlet weak var propertiesSet: UIView!
    
    
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var viewsContainerLeading: NSLayoutConstraint!
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var inloveButton: UIButton!
    @IBOutlet weak var coolButton: UIButton!
    @IBOutlet weak var sleepyButton: UIButton!
    
    @IBOutlet weak var pickMovieButton: UIButton!
    
    @IBAction func nextView(sender: AnyObject) {
        if allowedToSwipe == 0 {
            return
        }
        
        if currentView == 1 || currentView == 2 {
            UIView.animateWithDuration(0.5, animations: {
                self.viewsContainerLeading.constant += self.screenWidth
                self.viewsContainer.layoutIfNeeded()

            })
            currentView++;
        }
    }
    
    @IBAction func prevView(sender: AnyObject) {
        if currentView == 2 || currentView == 3 {
            UIView.animateWithDuration(0.5, animations: {
                self.viewsContainerLeading.constant -= self.screenWidth
                self.viewsContainer.layoutIfNeeded()
            })
            currentView--;
        }
    }
    
    
    @IBAction func moodButtonClicked(sender: AnyObject) {
        allowedToSwipe = 1
        let clicked = sender as! UIButton
        let clickedTag = clicked.tag
        
        if (moodButtons[clickedTag].3 == 0) {
            for i in 0...5 {
                if (moodButtons[i].3 == 1) {
                    moodButtons[i].3 = 0
                    moodButtons[i].0.setImage(UIImage(named: moodButtons[i].1), forState: UIControlState())
                    break
                }
            }
            
            clicked.setImage(UIImage(named: moodButtons[clickedTag].2), forState: UIControlState())
            moodButtons[clickedTag].3 = 1
        }
    }
    
    func keywordSelected(sender: UIButton) {
        if keywords.changeStatus(sender.tag) == 0 {
            //sender.backgroundColor = nil
            sender.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        else {
            //sender.backgroundColor = UIColor.whiteColor()
            sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            sender.setTitleColor(UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1), forState: UIControlState.Normal)
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            if (currentView == 2) {
                for i in 0...(KEYWORDS_NUMBER-1) {
                    keywords.entries[i].2 = 1
                }
                
                for button in keywordsSet.subviews {
                    if button as? UIButton != nil {
                        keywordSelected(button as! UIButton)
                    }
                }
            }
            
            if (currentView == 3) {
                for i in KEYWORDS_NUMBER...(keywords.entries.count-1) {
                    keywords.entries[i].2 = 1
                }
                
                for button in propertiesSet.subviews {
                    if button as? UIButton != nil {
                        keywordSelected(button as! UIButton)
                    }
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("background", withExtension: "html")!
        webViewBackground.loadRequest(NSURLRequest(URL: url))
        webViewBackground.scrollView.scrollEnabled = false;
        
        moodButtons.append((happyButton, "happy-button", "happy-button-reverse", 0))
        moodButtons.append((sadButton, "sad-button", "sad-button-reverse", 0))
        moodButtons.append((angryButton, "angry-button", "angry-button-reverse", 0))
        moodButtons.append((inloveButton, "inlove-button", "inlove-button-reverse", 0))
        moodButtons.append((coolButton, "cool-button", "cool-button-reverse", 0))
        moodButtons.append((sleepyButton, "sleepy-button", "sleepy-button-reverse", 0))
        
        var i = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var w: CGFloat = 0
        var h: CGFloat = 0

        
        for kword in keywords.entries {
            let button = UIButton()
            w = 9 * CGFloat((kword.0).characters.count) + 15
            h = 30
            
            if x + w > self.screenWidth - 20 {
                x = 0
                y += h + 10
            }
            
            if (i == KEYWORDS_NUMBER) {
                y = 0;
                x = 0;
            }
                
            button.frame = CGRectMake(x, y, w, h)
            button.setTitle(kword.0, forState: UIControlState.Normal)
            button.addTarget(self, action: "keywordSelected:", forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
            button.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
            
            /*
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.layer.borderWidth = 2 */
            
            if (i < KEYWORDS_NUMBER) {
                self.keywordsSet.addSubview(button)
            }
            else {
                self.propertiesSet.addSubview(button);
            }
            
            i++
            x += w + 10

        }
        pickMovieButton.layer.borderColor = UIColor.whiteColor().CGColor
        pickMovieButton.layer.borderWidth = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
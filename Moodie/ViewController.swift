//
//  ViewController.swift
//  Controls the first View containing three screens (the homescreen and two keyword sets)
//  Moodie
//
//  Created by Ilya Ilyankou and Anastasija Mensikova on 11/10/15.
//  Copyright © 2015 Ilya Ilyankou and Anastasija Mensikova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var KEYWORDS_NUMBER = 0;
    var PROPERTIES_NUMBER = 0;
    
    var moodButtons: [(UIButton, String, String, Int)] = []
    var keywords = Keywords()
    var currentView = 1             // either 1, 2, or 3
    var currentMood = -1            // 0 through 5, -1 if nothing is selected
    var allowedToSwipe = 0          // turns to 1 as soon as mood button is clicked
    var returned = 0                // 1 if there was a segue from SeconViewController to here
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    // Loading the necessary outlets
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
    
    /**
        Initialisation of preset keywords depending on the mood picked
     */
    var keywordsForButton = [
        [2, 11, 20, 21, 24, 38, 45],   //  happy
        [0, 3, 12, 22, 57],   //  sad
        [2, 8, 11, 14, 48, 51],   //  angry
        [2, 13, 16, 20, 26, 27, 35, 38, 54, 65, 79],   //  inlove
        [3, 10, 15, 19, 29, 32, 46, 55],   //  cool
        [1, 16, 24, 38, 53]    //  sleepy
    ]
    
    @IBOutlet weak var pickMovieButton: UIButton!
    
    
    /**
        Manages the action when the user swipes to the next screen; checks if the swipe can be performed
     */
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
    
    
    /**
        Manages the action when the user swipes to the previous screen; checks if the swipe can be performed
     */
    @IBAction func prevView(sender: AnyObject) {
        if currentView == 2 || currentView == 3 {
            UIView.animateWithDuration(0.5, animations: {
                self.viewsContainerLeading.constant -= self.screenWidth
                self.viewsContainer.layoutIfNeeded()
            })
            currentView--;
        }
    }
    
    
    /**
        Changes the state and look of the mood button once it's clicked.
        Sets preselected keywords based on the button clicked
     
        - Parameter sender: the mood button
     */
    @IBAction func moodButtonClicked(sender: AnyObject) {
        let clicked = sender as! UIButton
        currentMood = clicked.tag
        
        if (allowedToSwipe == 0) {
            allowedToSwipe = 1;
        }
        
        if (moodButtons[currentMood].3 == 0) {
            for i in 0...5 {
                if (moodButtons[i].3 == 1) {
                    moodButtons[i].3 = 0
                    moodButtons[i].0.setImage(UIImage(named: moodButtons[i].1), forState: UIControlState())
                    break
                }
            }
            
            clicked.setImage(UIImage(named: moodButtons[currentMood].2), forState: UIControlState())
            moodButtons[currentMood].3 = 1
            
            if self.returned == 0 {
                setSuggestedKeywords()
            }
            else {
                setExistingKeywords(keywords.entries)
            }
        }
    }
    
    
    /**
        Changes the state and look of the keyword button once it's clicked
     
        - Parameter sender: the keyword button
        - Returns: nothing
     */
    func keywordSelected(sender: UIButton) {
        if keywords.changeStatus(sender.tag) == 0 {
            sender.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        else {
            sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            sender.setTitleColor(UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1), forState: UIControlState.Normal)
        }
    }
    
    
    /**
        Resets keywords to suggested when phone is shaken
    
        - Parameters:
            - motion: the motion of the phone (the shake)
            - event: the event accompanying the motion
    */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            setSuggestedKeywords()
        }
    }
    
    
    /**
        Deselects (clears) all keywords
    */
    func clearAllKeywords()  {
        for i in 0...(keywords.entries.count-1) {
            keywords.entries[i].2 = 1
        }
        
        for button in propertiesSet.subviews {
            if button as? UIButton != nil {
                keywordSelected(button as! UIButton)
            }
        }
        
        for button in keywordsSet.subviews {
            if button as? UIButton != nil {
                keywordSelected(button as! UIButton)
            }
        }
    }
    
    
    /**
        Resets keywords on both pages to suggested (preselected)
    */
    func setSuggestedKeywords() {
        clearAllKeywords()
        let suggestedKeywords = keywordsForButton[currentMood]
        
        for i in 0...(suggestedKeywords.count-1) {
            
            for view in keywordsSet.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if btn.tag == suggestedKeywords[i] {
                        keywordSelected(btn)
                        break
                    }
                }
            }
            
            for view in propertiesSet.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if btn.tag == suggestedKeywords[i] {
                        keywordSelected(btn)
                        break
                    }
                }
            }
        }
    }
    
    
    /**
        Sets keywords selected by the user
     
        - Parameter kws: a Keyword entry
        - Returns: nothing
     */
    func setExistingKeywords(kws: [(String, Int, Int)]) {
        clearAllKeywords()

        for i in 0...(kws.count-1) {
            // Going through all the UIViews
            for view in keywordsSet.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if btn.tag == i {
                        if (kws[i].2 == 1) {
                            keywordSelected(btn)
                            break
                        }
                    }
                }
            }
            
            for view in propertiesSet.subviews as [UIView] {
                if let btn = view as? UIButton {
                    if btn.tag == i {
                        if (kws[i].2 == 1) {
                            keywordSelected(btn)
                            break
                        }
                    }
                }
            }
            
            self.returned = 0
        }
    }
    
    /**
        Initializes the array moodButtons with necessary info and button status
     */
    func initializeMoodButtons() {
        moodButtons.append((happyButton, "happy-button", "happy-button-reverse", 0))
        moodButtons.append((sadButton, "sad-button", "sad-button-reverse", 0))
        moodButtons.append((angryButton, "angry-button", "angry-button-reverse", 0))
        moodButtons.append((inloveButton, "inlove-button", "inlove-button-reverse", 0))
        moodButtons.append((coolButton, "cool-button", "cool-button-reverse", 0))
        moodButtons.append((sleepyButton, "sleepy-button", "sleepy-button-reverse", 0))
    }
    
    
    /**
        Load animated background
     */
    func initializeBackground() {
        let url = NSBundle.mainBundle().URLForResource("background", withExtension: "html")!
        webViewBackground.loadRequest(NSURLRequest(URL: url))
        webViewBackground.scrollView.scrollEnabled = false
    }
    
    
    /**
        Initialisation of the app and the VC: sets background image, adds mood buttons, adds keywords
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBackground()
        initializeMoodButtons()
        
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
                y += h + (self.screenHeight / 40)
            }
            
            // Re-set x and y for the second page
            if KEYWORDS_NUMBER == 0 && y > self.screenHeight - 20 - h {
                KEYWORDS_NUMBER = i
                y = 0
                x = 0
            }
            
            // Finish generating keyword buttons when "Pick a movie" button reached
            if KEYWORDS_NUMBER > 0 && y > self.screenHeight - (1/4)*self.screenHeight - h {
                break
            }
                
            button.frame = CGRectMake(x, y, w, h)
            button.setTitle(kword.0, forState: UIControlState.Normal)
            button.addTarget(self, action: "keywordSelected:", forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
            button.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
            
            if (KEYWORDS_NUMBER == 0) {
                self.keywordsSet.addSubview(button)
            }
            else {
                self.propertiesSet.addSubview(button)
            }
            
            i++
            x += w + (self.screenWidth / 40)

        }
        
        pickMovieButton.layer.borderColor = UIColor.whiteColor().CGColor
        pickMovieButton.layer.borderWidth = 5
        
        if (currentMood > -1) {
            switch (currentMood) {
            case 0:
                moodButtonClicked(happyButton)
            case 1:
                moodButtonClicked(sadButton)
            case 2:
                moodButtonClicked(angryButton)
            case 3:
                moodButtonClicked(inloveButton)
            case 4:
                moodButtonClicked(coolButton)
            case 5:
                moodButtonClicked(sleepyButton)
            default:
                print("should never reach that")
            }
            
            nextView(UIButton())
            nextView(UIButton())
        }
        
    }

    
    /**
        Passes necessary information to the SecondViewController before the segue
     
        - Parameters:
            - segue: the segue to the next VC
            - sender: the button that leads to the SecondViewController ("Pick a Movie!")
        - Returns: nothing
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondScene = segue.destinationViewController as! SecondViewController
        secondScene.keywords = self.keywords
        secondScene.mood = self.currentMood
    }

    
    /**
     Disposes of any resources that can be recreated.
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
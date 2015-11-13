//
//  ViewController.swift
//  Moodie
//
//  Created by Ilya Ilyankou on 11/10/15.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var moodButtons : [(UIButton, String, String, Int)] = []
    var currentView = 1
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    @IBOutlet weak var webViewBackground: UIWebView!
    
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var keywordSet1: UIView!
    
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var viewsContainerLeading: NSLayoutConstraint!
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var inloveButton: UIButton!
    @IBOutlet weak var coolButton: UIButton!
    @IBOutlet weak var sleepyButton: UIButton!
   
    
    
    @IBAction func nextView(sender: AnyObject) {
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
    
    
    @IBAction func buttonClicked(sender: AnyObject) {
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
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


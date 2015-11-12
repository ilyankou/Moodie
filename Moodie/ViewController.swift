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
    
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var angryButton: UIButton!
    @IBOutlet weak var inloveButton: UIButton!
    @IBOutlet weak var coolButton: UIButton!
    @IBOutlet weak var sleepyButton: UIButton!
    
    @IBOutlet weak var webViewBackground: UIWebView!
    
    
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


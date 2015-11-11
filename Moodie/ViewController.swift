//
//  ViewController.swift
//  Moodie
//
//  Created by Ilya Ilyankou on 11/10/15.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var moodButtons: [UIButton]!
    @IBOutlet weak var webViewBackground: UIWebView!
    
    @IBAction func buttonClicked(sender: AnyObject) {
        let clicked = sender as! UIButton
        if (clicked.backgroundColor != UIColor.whiteColor()) {
            for button in self.moodButtons {
                button.backgroundColor = nil
                clicked.backgroundColor = UIColor.whiteColor();
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSBundle.mainBundle().URLForResource("background", withExtension: "html")!
        webViewBackground.loadRequest(NSURLRequest(URL: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


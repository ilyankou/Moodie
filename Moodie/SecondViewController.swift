//
//  SecondViewController.swift
//  Moodie
//
//  Created by Ilya Ilyankou on 12/4/15.
//  Copyright © 2015 Ilya Ilyankou. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tvBg: UIWebView!
    
    var keywords: Keywords?
    var mood = 0
    var moodieRanking : [Double] = [0.0]
    var moodieFinal : [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSBundle.mainBundle().URLForResource("tv-bg", withExtension: "html")!
        tvBg.loadRequest(NSURLRequest(URL: url))
        tvBg.scrollView.scrollEnabled = false;
        
        let path = NSBundle.mainBundle().pathForResource("movies", ofType:"db")
        let database = FMDatabase(path: path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
        
        var sql = "SELECT * FROM MOVIES;"
        var rs = database.executeQuery(sql, withArgumentsInArray: nil)
        
        while rs.next() {
            
            let id = Int(rs.intForColumn("ID"))
            let dbKeywords = String(rs.stringForColumn("KEYWORDS"))
            
            let denom = Double(dbKeywords.componentsSeparatedByString(" ").count)
            
            let dbRating = Double(rs.doubleForColumn("RATING"))
            
            moodieRanking.append(100.0)
            
            
            for kword in keywords!.entries {
                if kword.2 == 0 {continue}
                
                let selectedKeyword = kword.0.stringByReplacingOccurrencesOfString(" ", withString:"-")
                
                if dbKeywords.rangeOfString(selectedKeyword) != nil {
                    moodieRanking[id] += 100.0 * Double(kword.1) / denom
                    
                }
                //let kwordWeight = kword.1
                
            }
            
            moodieRanking[id] *= dbRating
            
            
            
        }
        
        
        
        // Getting the list of 10 highest Moodie-rated movies
        for _ in 0...9 {
            var max = 0.0
            var maxIndex = 0
            
            for j in 1...(moodieRanking.count-1) {
                if moodieRanking[j] > max {
                    max = moodieRanking[j]
                    maxIndex = j
                }
            }
            
            
            sql = "SELECT * FROM MOVIES WHERE ID = \(maxIndex);"
            rs = database.executeQuery(sql, withArgumentsInArray: nil)
            
            rs.next()
            let myTitle = String(rs.stringForColumn("TITLE"))
            let myYear = String(rs.intForColumn("YEAR"))
            
            moodieFinal.append(["title": myTitle, "year": myYear])
            
            moodieRanking[maxIndex] = 0.0
            
        }
        
        
        database.close()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodieFinal.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        let movieTitleLabel = self.view.viewWithTag(69) as! UILabel
        let moviePlotLabel = self.view.viewWithTag(79) as! UILabel
        let moviePoster = self.view.viewWithTag(99) as! UIImageView
        
        
        let movieTitle = moodieFinal[indexPath.row]["title"]!
        let movieYear = moodieFinal[indexPath.row]["year"]!
        
        let movieData = parseJSON(getJSONforMovie(movieTitle, year: movieYear))
        
        
        movieTitleLabel.text = "\(movieTitle) (\(movieYear))"
        
        moviePlotLabel.text = movieData["Plot"] as? String
        
        let imgURL = NSURL(string: (movieData["Poster"] as? String)!)
        if let imgData = NSData(contentsOfURL: imgURL!) {
            moviePoster.image = UIImage(data: imgData)
        }
        
        
        return cell
    }
    
    
    func getJSONforMovie(var titleToRequest: String, year: String) -> NSData {
        titleToRequest = titleToRequest.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        if let toReturn = NSData(contentsOfURL: (NSURL(string: "http://www.omdbapi.com/?t=\(titleToRequest)&y=\(year)&plot=full&r=json")!)) {
            return toReturn
        }
        
        return NSData()
    }
    
    
    
    func parseJSON(data: NSData) -> NSDictionary {
        
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                print(jsonResult)
                return jsonResult
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return NSDictionary()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 700.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let firstScene = segue.destinationViewController as! ViewController
        firstScene.keywords = self.keywords!
        firstScene.currentMood = self.mood
        firstScene.allowedToSwipe = 1
        firstScene.returned = 1
        /*
        for vw in firstScene.view.subviews {
            if vw.tag == self.mood {
                if let moodButton = vw as? UIButton {
                    firstScene.moodButtonClicked(moodButton)
                    break
                }
            }
        }*/
        
    }
    
}

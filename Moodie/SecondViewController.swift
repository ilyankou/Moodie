//
//  SecondViewController.swift
//  Calculates the best movie matches and displays them
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
    var moodieFinalPosters : [NSData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading the grey animated background
        loadBackground()
        
        // Opening the database
        let path = NSBundle.mainBundle().pathForResource("movies", ofType:"db")
        let database = FMDatabase(path: path)
        
        if !database.open() {
            print("Unable to open database")
        }
        
        
        // Selecting all contents of the MOVIES table
        var sql = "SELECT * FROM MOVIES;"
        var rs = database.executeQuery(sql, withArgumentsInArray: nil)
        
        // For each entry in the MOVIES table, calculating ranking
        while rs.next() {
            let id = Int(rs.intForColumn("ID"))
            let dbKeywords = String(rs.stringForColumn("KEYWORDS"))
            let denom = Double(dbKeywords.componentsSeparatedByString(" ").count)
            let dbRating = Double(rs.doubleForColumn("RATING"))
            
            moodieRanking.append(dbRating)
            
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
        
        
        // Getting the list of 20 highest Moodie-rated movies
        for _ in 0...19 {
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
            
            let movieData = parseJSON(getJSONforMovie(myTitle, year: myYear))
            
            if movieData["Plot"] != nil {
            // Retrieving necessary info from NSDictionary containing appropriate JSON
                moodieFinal.append(["title": myTitle,
                    "year": myYear,
                    "plot": (movieData["Plot"] as! String) + " More...",
                    "poster": movieData["Poster"] as! String,
                    "imdbid": movieData["imdbID"] as! String
                    ])

                // Retrieving the poster image
                let imgURL = NSURL(string: movieData["Poster"] as! String)
                if let imgData = NSData(contentsOfURL: imgURL!) {
                    moodieFinalPosters.append(imgData)
                }
                
                // If the poster can't be retrieved, load "no movie poster"
                else {
                    moodieFinalPosters.append(NSData(contentsOfURL: NSURL(string: "https://ilyankou.files.wordpress.com/2015/12/noposteravailable.jpg")!)!)
                }
                
                
            }
            // In case OMDb did not have the movie, set things empty
            else {
                moodieFinal.append(["title": myTitle,
                    "year": myYear,
                    "plot": "No description available.",
                    "poster": "n",
                    "imdbid": "n"
                    ])
                
                // The "no movie poster" image
                let imgURL = NSURL(string: "https://ilyankou.files.wordpress.com/2015/12/noposteravailable.jpg")
                if let imgData = NSData(contentsOfURL: imgURL!) {
                    moodieFinalPosters.append(imgData)
                }
            }
            
            moodieRanking[maxIndex] = 0.0
        }
        
        database.close()
    }
    
    
    /**
        Sets the animated grey background
     */
    func loadBackground() {
        let url = NSBundle.mainBundle().URLForResource("tv-bg", withExtension: "html")!
        tvBg.loadRequest(NSURLRequest(URL: url))
        tvBg.scrollView.scrollEnabled = false;
    }
    
    
    /**
        One section for the table view
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    /**
        Twenty reusable cells for the table view
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        //return moodieFinal.count
    }
    
    
    /**
        Calculates and returns the height of a cell depending on the movie description length
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let descriptionLength = CGFloat(moodieFinal[indexPath.row]["plot"]!.characters.count)
        return 550.0 + descriptionLength * 0.5
    }
    

    /**
        Customizes and returns reusable cell at indexPath
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        // Gets the elements of cell's layout by their tags
        let movieTitleLabel = self.view.viewWithTag(69) as! UILabel
        let moviePlotButton = self.view.viewWithTag(79) as! UIButton
        let moviePosterLabel = self.view.viewWithTag(99) as! UIImageView
        
        // Retrieves movie title, year, and description from the array
        let movieTitle = moodieFinal[indexPath.row]["title"]!
        let movieYear = moodieFinal[indexPath.row]["year"]!
        let moviePlot = moodieFinal[indexPath.row]["plot"]!
        
        // Sets the UI: label for movie title, and title for button with description
        movieTitleLabel.text = "\(movieTitle) (\(movieYear))"
        moviePlotButton.setTitle(moviePlot, forState: UIControlState.Normal)
        moviePlotButton.titleLabel?.textAlignment = .Center

        // Sets the image
        if indexPath.row < moodieFinalPosters.count {
            moviePosterLabel.image = UIImage(data: self.moodieFinalPosters[indexPath.row])
        }
        
        // Do "goToIMDB()" when description button is hit
        moviePlotButton.addTarget(self, action: "goToIMDB:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
    }
    
    
    /**
        Opens the browser app with the movie description on IMDB website
     
        - Parameter sender: the button with the movie description
        - Returns: nothing
    */
    func goToIMDB (sender : AnyObject) {
        let lbl = sender as! UIButton
        
        for i in 0...19 {
            if moodieFinal[i]["plot"] == lbl.currentTitle {
                let imdbURL = String("http://imdb.com/title/" + moodieFinal[i]["imdbid"]!)
                UIApplication.sharedApplication().openURL(NSURL(string: imdbURL)!)
            }
        }
    }
    
    
    /**
        Fetches the JSON with movie information using OMDb API
     
        - Parameters:
            - titleToRequest: title of the movie we want to get info for
            - year: the year of this movie, to insure we get the right movie
     
        - Returns: an NSData object with JSON about the movie, or an empty NSData
                   if wasn't able to fetch the contents of the URL
     */
    func getJSONforMovie(var titleToRequest: String, year: String) -> NSData {
        titleToRequest = titleToRequest.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        if let toReturn = NSData(contentsOfURL: (NSURL(string: "http://www.omdbapi.com/?t=\(titleToRequest)&y=\(year)&plot=short&r=json")!)) {
            return toReturn
        }
        // If couldn't fetch, return empty NSData
        return NSData()
    }
    
    
    /**
        Converts NSData into NSDictionary using NSJSONSerialization
     
        - Parameter data: an NSData object containing JSON from OMDb
        - Returns: an NSDictionary object with the same information
     */
    func parseJSON(data: NSData) -> NSDictionary {
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                return jsonResult
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return NSDictionary()
        
    }
    
    
    /**
        Sets the necessary variables of the First View Controller before going to it
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let firstScene = segue.destinationViewController as! ViewController
        firstScene.keywords = self.keywords!
        firstScene.currentMood = self.mood
        firstScene.allowedToSwipe = 1
        firstScene.returned = 1
    }
    
    
    /**
        Don't do anything unusual thing when memory warning received. Because, well, what can you do?
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
